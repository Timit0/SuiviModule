
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/provider/student_provider.dart';

enum EleveState
{
  // ignore: constant_identifier_names
  Create,
  // ignore: constant_identifier_names
  Edit,
  // ignore: constant_identifier_names
  Delete
}

class EleveActionScreen extends StatefulWidget {
  EleveActionScreen({super.key});

  @override
  State<EleveActionScreen> createState() => _EleveActionScreenState();
}

class _EleveActionScreenState extends State<EleveActionScreen> {
  EleveState formState = EleveState.Create;

  final _form = GlobalKey<FormState>();

  final TextEditingController getCp = TextEditingController();

  final TextEditingController getName = TextEditingController();

  final TextEditingController getNickName = TextEditingController();

  final TextEditingController getPicture = TextEditingController();

  var _isInit = true;
  var _isLoading = false;

  bool disposeOption = false;

  
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   getCp.dispose();
  //   getName.dispose();
  //   getNickName.dispose();
  //   getPicture.dispose();
  // }

  

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
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
    final provider = Provider.of<StudentProvider>(context);
    return Stack(
      children: [
        SwitchListTile(
          dense: false,
          tileColor: Color.fromARGB(0, 255, 255, 255),
          activeColor: Colors.red,
          title: const Text('Supprimer'),
          value: disposeOption,
          onChanged: (bool value) {
            setState(() {
              disposeOption = value;
              if(value){
                formState = EleveState.Delete;
              }else{
                for (var v in provider.allEleves) {
                  if(v.id == getCp.text){
                    formState = EleveState.Edit;
                    return;
                  }else{
                    if(canClearGetText){
                      canClearGetText = false;
                      
                      getName.text = "";
                      getNickName.text = "";
                      getPicture.text = "";
                    }
                    formState = EleveState.Create;
                  }
                }
              }
            });
          },
        ),
        Center(
          child: form(provider, disposeOption)
        ),
      ],
    );
  }

  Widget sendButton(EleveState eleveState){
    if(eleveState == EleveState.Create){
      return const Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 500,
            ),
            Center(
              child: Text("Create"),
            )
          ],
        ),
      );
    }else if(eleveState == EleveState.Edit){
      return const Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 500,
            ),
            Center(
              child: Text("Edit"),
            )
          ],
        ),
      );
    }else{
      return const Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 500,
            ),
            Center(
              child: Text("Delete"),
            )
          ],
        ),
      );
    }
    
  }
  bool canClearGetText = false;

  Widget form(StudentProvider provider, bool disposeOption){
    if(disposeOption){
      return Form(
        key: _form,
        child: SizedBox(
          width: 500,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: getCp,
                decoration: const InputDecoration(
                  label: Text("CP"),
                  hintText: "Ex : cp-00abc"
                ),
                validator: (value) {
                  if(value.isNull){
                    return "La valeur ne peut pas etre null";
                  }
        
                  if(!value!.contains("-") || !value.contains("cp")){
                    return "La valeur n'est pas juste ! Suivez l'exemple";
                  }

                  for (var v in provider.allEleves) {
                    if(v.id == getCp.text){
                      getName.text = v.name;
                      getNickName.text = v.firstname;
                      getPicture.text = v.photoFilename; 
                      return null;
                    }
                  }
                  return "L'étudiant n'existe pas !!!!";
                },
              ),
              GestureDetector(
                child: sendButton(formState),
                onTap: () {
                  final isValid = _form.currentState!.validate();
                  if (!isValid) {
                    return;
                  }

                  Eleve eleve = Eleve(
                    id: getCp.text, 
                    name: getName.text, 
                    firstname: getNickName.text,
                    photoFilename: getPicture.text
                  );

                  provider.removeEleveAndRef(eleve);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('L\'élève à était supprimmé de la liste avec succés!')
                  ));

                  setState(() {
                    getCp.text = "";
                    getName.text = "";
                    getNickName.text = "";
                    getPicture.text = "";
                  });
                },
              ),
            ],
          ),
        ),
      ); 
    }
    return Form(
      key: _form,
      child: SizedBox(
        width: 500,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: getCp,
              decoration: const InputDecoration(
                label: Text("CP"),
                hintText: "Ex : cp-00abc"
              ),
              onChanged: (value) {
               if(formState != EleveState.Delete){
                  for (var v in provider.allEleves) {
                    if(v.id == value){
                      setState(() {
                        canClearGetText = true;
                        getName.text = v.name;
                        getNickName.text = v.firstname;
                        getPicture.text = v.photoFilename; 
                        formState = EleveState.Edit;
                      });
                      return;
                    }else{
                      setState(() {
                        if(canClearGetText){
                          canClearGetText = false;

                          getName.text = "";
                          getNickName.text = "";
                          getPicture.text = "";
                        }
                        formState = EleveState.Create;
                      });
                    }
                  }
                }
              },
              validator: (value) {
                if(value.isNull){
                  return "La valeur ne peut pas etre null";
                }
      
                if(!value!.contains("-") || !value.contains("cp")){
                  return "La valeur n'est pas juste ! Suivez l'exemple";
                }
                return null;
              },
            ),
            TextFormField(
              controller: getName,
              decoration: const InputDecoration(
                label: Text("Nom"),
                hintText: "Ex : Doe"
              ),
              validator: (value) {
                if(value.isNull){
                  return "La valeur ne peut pas être null";
                }
                return null;
              },
            ),
            TextFormField(
              controller: getNickName,
              decoration: const InputDecoration(
                label: Text("Prénom"),
                hintText: "Ex : John"
              ),
              validator: (value) {
                if(value.isNull){
                  return "La valeur ne peut pas être null";
                }
                return null;
              },
            ),
            TextFormField(
              controller: getPicture,
              decoration: const InputDecoration(
                label: Text("Image"),
                hintText: "Ex : https://www.xxx.com/placholder.png"
              ),
            ),
            
            GestureDetector(
              child: sendButton(formState),
              onTap: () {
                final isValid = _form.currentState!.validate();
                if (!isValid) {
                  return;
                }
  
                if(getPicture.text.isEmpty){
                  getPicture.text == "assets/img/placeholderImage.png";
                }
  
                final eleve = Eleve(
                  id: getCp.text, 
                  name: getName.text, 
                  firstname: getNickName.text, 
                  photoFilename: getPicture.text
                );
  
                provider.createOrAddOneEleve(eleve);
                setState(() {
                  getCp.text = "";
                  getName.text = "";
                  getNickName.text = "";
                  getPicture.text = "";
                });

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('L\'élève à était ajouté avec succés!')
                ));

                //dispose();
              },
            ),
          ],
        ),
      ),
    );
  }
}