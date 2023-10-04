import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/global/global_information.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';

import '../provider/module_provider.dart';
import '../provider/student_provider.dart';
import '../widget/student_card.dart';

class StudentListScreen extends StatefulWidget {
  StudentListScreen({super.key, required this.moduleId});
  String moduleId;

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();


  static void Refresh()
  {
    _refreshCode?.call();
  }

  static Function? _refreshCode;
}

class _StudentListScreenState extends State<StudentListScreen> {

  bool isAddMode = false;

  bool _isInit = true;
  bool _isLoading = false;

  final _form = GlobalKey<FormState>();

  final TextEditingController getId = TextEditingController();

  String state = "L'élève n'existe pas";

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<StudentProvider>(context, listen: false).fetchAndSetStudents(widget.moduleId);
      await Provider.of<StudentProvider>(context, listen: false).fetchAndSetAllStudents();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    StudentListScreen._refreshCode = (){
      setState(() {
        isAddMode = !isAddMode;
      });
    };
    StudentProvider studentProvider = Provider.of<StudentProvider>(context);
    return _isLoading ? const Center(child: CircularProgressIndicator())
        : screenDisplay(studentProvider);
    //return Text("Test");
  }

  Widget screenDisplay(StudentProvider studentProvider){
    Stage stage = StageScreen.instance.getStageScreen();

    if(stage == Stage.eleves){
      return studentListBuilder(studentProvider);
    }else if(stage == Stage.eleveDetail){
      return DetailsStudentScreen();
    }else{
      return Text("ERROR");
    }
  }

  Widget studentListBuilder(StudentProvider studentProvider){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 100, right: 100, bottom: 200, top: 50),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: studentProvider.eleves.length,
              itemBuilder: (context, index) {
                return StudentCard(
                  eleve: studentProvider.eleves[index], 
                  moduleId: widget.moduleId,
                  deleteButtonBehavior: () async{
                    await studentProvider.removeEleveFromOneModule(studentProvider.eleves[index].id, widget.moduleId);
                    //ModuleScreen.Refresh();
                    
                    setState(() /*async*/ {
                      // await Provider.of<ModuleProvider>(context, listen: false).fetchAndSetModules();
                    });
                  },
                  detailButtonBehavior: (){
                    setState(() {
                      StageScreen.instance.setStageScreen(Stage.eleveDetail);
                      GlobalInformation.eleve = studentProvider.eleves[index];
                      GlobalInformation.moduleNum = widget.moduleId;
                      ModuleScreen.Refresh();
                    });
                  },
                ); 
              }
            ),
          ),
        ),
        addWidget(),
      ],
    );
  }

  Widget addWidget(){
    switch(isAddMode){
      case false:
        return Container();
      case true:
        final provider = Provider.of<StudentProvider>(context);
        return Form(
          key: _form,
          child: Container(
            width: 300,
            height: double.infinity,
            color: const Color.fromARGB(255, 201, 201, 201),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isAddMode = false;
                          });
                        },
                        child: Icon(
                          Icons.close
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(state),
                      TextFormField(
                        controller: getId,
                        decoration: const InputDecoration(
                          label: Text("ID élève"),
                          hintText: "Ex : cp-21tih"
                        ),
                        validator: (value) {
                          if(value == null || !value.contains("-")){
                            return "Le nommage ne correspond pas !!!";
                          }
                                
                          if(value.split("-").length != 2){
                            return "Le nommage ne correspond pas !!!";
                          }
                                
                          return null;
                        },
                        onChanged: (value) {
                          print(getId.text);
                          for (var v in provider.allEleves) {
                            print(v.id);
                            if(v.id == getId.text){
                              setState(() {
                                print("SetState");
                                state = "L'élève exist";
                              });
                              return;
                            }
                            // if(state == "L'élève exist"){
                              setState(() {
                                print("AGGAIN");
                                state = "L'élève n'existe pas";
                              });
                            // }
                          }
                        },
                      ),
                      sendButton()
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget sendButton(){
    return GestureDetector(
      onTap: () {
        final isValid = _form.currentState!.validate();
        if (!isValid) {
          return;
        }
        Provider.of<StudentProvider>(context, listen: false).addEleveRefToModule(widget.moduleId, getId.text);
        setState(() {
          getId.text = "";
        });
      },
      child: const Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
            ),
            Center(
              child: Text("Ajouter l'élève"),
            )
          ],
        ),
      )
    );
  }
}