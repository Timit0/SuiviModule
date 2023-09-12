import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/widget/eleve_action_screen.dart';
import 'package:suivi_de_module/widget/module_widget.dart';
// import 'package:suivi_de_module/widget/pop_up_module_creation.dart';
import 'package:intl/intl.dart'; // DateFormat


enum Mode
{
  none,
  moduleAdditionMode,
  moduleEditionMode
}

class ModuleScreen extends StatefulWidget {
  static const routeName = '/details_student_screen';
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {

  var _isInit = true;
  var _isLoading = false;
  int _selectedIndex = 0;
  int _selectedIndex2 = 0;

  final formKey = GlobalKey<FormState>();

  final moduleNameController = TextEditingController();
  final moduleDescriptionController = TextEditingController();
  final moduleDayDateController = TextEditingController();
  final moduleClassController = TextEditingController();

  late Mode mode = Mode.none; 

  @override
  void didChangeDependencies() async {

    if (_isInit) {
      _isLoading = true;
      await Provider.of<ModuleProvider>(context).fetchAndSetModules();
      //await Provider.of<StudentProvider>(context).fetchAndSetAllStudents();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final moduleProvider = Provider.of<ModuleProvider>(context);
    NavigationRailLabelType labelType = NavigationRailLabelType.all;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Module", 
          style: 
          TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),

      body: Row(
        children: [
          NavigationRail(
            elevation: 2,
            backgroundColor: const Color.fromARGB(255, 207, 207, 207),
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            destinations: const[
              NavigationRailDestination(
                icon: Icon(Icons.view_module), 
                label: Text("Modules"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_add), 
                label: Text("Ajouter/Modifier/Supprimer\nélèves"),
              ),
            ], 
            selectedIndex: _selectedIndex,
            labelType: labelType,
          ),
          Flexible(
            child: screen(moduleProvider),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.grey
            ),
            
            child: Form(
              key: formKey,
              child: Column(
                children: mode == Mode.none
                  ? []
                  : (mode == Mode.moduleAdditionMode || mode == Mode.moduleEditionMode)
                    ? [
                      Row(
                        children: [
                          IconButton(onPressed: () {
                            moduleClassController.text = "";
                            moduleDayDateController.text = "";
                            moduleDescriptionController.text = "";
                            moduleNameController.text = "";
                            
                            setState(() {mode = Mode.none;});
                            }, icon: const Icon(Icons.close)),

                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text('${mode == Mode.moduleAdditionMode ? 'Ajout' : 'Edition'} de module', style: const TextStyle(fontSize: 25)),
                          ),

                        ]
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38.0),
                        child: SizedBox(
                          width: 250,
                          child: TextFormField(
                            controller: moduleNameController,
                            validator: (value){
                              if (value == "") { return "Le module doit avoir un identifiant"; }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'L\'identifiant du module',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 38.0),
                        child: SizedBox(
                          width: 250,
                          height: 250,
                          child: TextFormField(
                            controller: moduleDescriptionController,
                            maxLines: 255,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: Colors.black,
                              hintText: 'Description du module',
                              border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 100,
                        child: TextFormField(
                          controller: moduleDayDateController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black,
                            hintText: 'La date (JJ.MM.AAAA)',
                            border: OutlineInputBorder()
                          ),
                          validator: (value) {

                            if (value == "") 
                            {
                              value = DateFormat('dd.MM.yyyy').format(DateTime.now()).toString();
                              moduleDayDateController.text = value;
                            }

                            final temp = value!.split('.');
                            
                            if (value != DateFormat('dd.MM.yyyy').format(DateTime.now()).toString())
                            {
                              if (temp.length != 3) { return "La date doit être marquée de la manière suivante : jj.mm.aaaa"; }
                              
                              if
                              (
                                int.tryParse(temp[0]) == null ||
                                int.tryParse(temp[1]) == null ||
                                int.tryParse(temp[2]) == null
                              )
                              {
                                return "La date doit être marquée de la manière suivante : jj.mm.aaaa";
                              }

                              if
                              (
                                (int.tryParse(temp[0])! <= 0 || int.tryParse(temp[0])! > 31) ||
                                (int.tryParse(temp[1])! <= 0 || int.tryParse(temp[1])! > 12) ||
                                (int.tryParse(temp[2])! <= 1925)
                              )
                              {
                                return "La date doit être marquée de la manière suivante : jj.mm.aaaa";
                              }
                              return null;
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        height: 100,
                        child: TextFormField(
                          controller: moduleClassController,
                          decoration: const InputDecoration(
                            hintText: 'Le nom de la classe',
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: Colors.black,
                            border: OutlineInputBorder()
                          ),
                          validator: ((value) => value == "" ? "Il faut que ce champ soit rempli!" : null)
                        )
                      ),
                      TextButton(
                        onPressed: (){
                          if (formKey.currentState!.validate())
                          {
                            if (moduleDayDateController.text == DateFormat('dd.MM.yyyy').format(DateTime.now()).toString())
                            {
                              Provider.of<ModuleProvider>(context, listen: false).createModule(Module(
                                nom: moduleNameController.text,
                                classe: moduleClassController.text,
                                description: moduleDescriptionController.text,
                                eleve: [],
                                horaire: moduleDayDateController.text,
                                devoirs: [],
                                tests: []
                              ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Le module à bien était ajouté dans la base de donnée!'))
                              );

                              setState((){});
                            }
                            else
                            {
                              
                              Provider.of<ModuleProvider>(context, listen: false).createPendingModule(Module(
                                nom: moduleNameController.text,
                                classe: moduleClassController.text,
                                description: moduleDescriptionController.text,
                                eleve: [],
                                horaire: moduleDayDateController.text,
                                devoirs: [],
                                tests: []
                              ));
                            
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Le module sera ajouté dans la list le ${moduleDayDateController.text}'))
                              );

                              setState((){ mode = Mode.none; });
                            }
                            
                          }
                          else
                          {

                          }
                        }, 
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 73, 73))
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Envoyer!',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        )
                      )
                    ]
                    : []
                  
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.upload_file_outlined) ,label: 'Importer un fichier JSON'),
        BottomNavigationBarItem(icon: Icon(Icons.upload_file_outlined) ,label: 'Importer un fichier CSV'),
      ], currentIndex: _selectedIndex2, unselectedItemColor: Colors.black, unselectedFontSize: 20, selectedFontSize: 20, fixedColor: Colors.black, onTap: (value) {
        // debug
        print(value);
        _selectedIndex2 = value;
        setState(() {});
      },),
    );
  }

  Widget screen(ModuleProvider moduleProvider){
    if(_selectedIndex == 0){
      return screenModule(moduleProvider);
    }else{
      return EleveActionScreen();
    }
    
  }

  Widget screenModule(ModuleProvider moduleProvider){
    return _isLoading ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Padding(
        padding: const EdgeInsets.only(left: 100, right: 100, bottom: 200),
        child: ListView.builder(
          itemCount: moduleProvider.modules.length,
          itemBuilder: (context, index) {
            return index+1 == moduleProvider.modules.length ? Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: ModuleWidget(
                  nom: moduleProvider.modules[index].nom, 
                  description: moduleProvider.modules[index].description, 
                  horaire: moduleProvider.modules[index].horaire, 
                  classe: moduleProvider.modules[index].classe,
                  eleve: moduleProvider.modules[index].eleve,
                  editionBehavior: () {
                    moduleNameController.text = moduleProvider.modules[index].nom;
                    moduleClassController.text = moduleProvider.modules[index].classe;
                    moduleDayDateController.text = moduleProvider.modules[index].horaire;
                    moduleDescriptionController.text = moduleProvider.modules[index].description;

                    setState(() {
                      mode = Mode.moduleEditionMode;
                    });
                  }
                ).buildWidget(context, index),
              ),
              TextButton(
                onPressed: () {
                    moduleClassController.text = "";
                    moduleDescriptionController.text = "";
                    moduleDayDateController.text = "";
                    moduleNameController.text = "";
                    setState(() {
                      mode = Mode.moduleAdditionMode;
                    });
                  } , style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey),
                ), 
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ajouter un module',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                      )
                    ),
                )
                )
            ]) : Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: ModuleWidget(
                nom: moduleProvider.modules[index].nom, 
                description: moduleProvider.modules[index].description, 
                horaire: moduleProvider.modules[index].horaire, 
                classe: moduleProvider.modules[index].classe,
                eleve: moduleProvider.modules[index].eleve,
                  editionBehavior: () {
                    moduleNameController.text = moduleProvider.modules[index].nom;
                    moduleClassController.text = moduleProvider.modules[index].classe;
                    moduleDayDateController.text = moduleProvider.modules[index].horaire;
                    moduleDescriptionController.text = moduleProvider.modules[index].description;

                    setState(() {
                      mode = Mode.moduleEditionMode;
                    });
                  }
              ).buildWidget(context, index),
            );
          },
        ),
      ),
    );
  }

  // void createModule(){
  //   PopUpModuleCreation popUpModuleCreation = PopUpModuleCreation();
  //   popUpModuleCreation.popUp(context);
  // }
}