import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/global/eleve_gestion_form_global.dart';

import '../enum/eleve_state.dart';
import '../models/eleve.dart';
import '../provider/student_provider.dart';
import '../screen/eleve_add_edit_screen.dart';

class EleveGestionForm extends StatefulWidget {
  EleveGestionForm({super.key, 
  required this.disposeOption,
  required this.formState,
  required this.form, 
  required this.getCp, 
  required this.getName, 
  required this.getNickName, 
  required this.getPicture,
  });

  bool disposeOption;

  EleveState formState;

  GlobalKey<FormState> form;

  TextEditingController getCp;

  TextEditingController getName;

  TextEditingController getNickName;

  TextEditingController getPicture;

  @override
  State<EleveGestionForm> createState() => _EleveGestionFormState();

  static void Refresh(){
    _refreshCode!.call();
  }

  static Function? _refreshCode;

  void updateController(){
    getCp.text = EleveGestionFormGlobal.cp;
    getName.text = EleveGestionFormGlobal.name;
    getNickName.text = EleveGestionFormGlobal.nickName;
    getPicture.text = EleveGestionFormGlobal.picture;
  }
}

class _EleveGestionFormState extends State<EleveGestionForm> {
  @override
  Widget build(BuildContext context) {
    EleveGestionForm._refreshCode = (){
      // if(mounted){
        setState(() {
          widget.updateController();
        });
      // }
    };
    final provider = Provider.of<StudentProvider>(context);
    return Stack(
      children: [
        SwitchListTile(
          dense: false,
          tileColor: Color.fromARGB(0, 255, 255, 255),
          activeColor: Colors.red,
          title: const Text('Supprimer'),
          value: widget.disposeOption,
          onChanged: (bool value) {
            if(!value){widget.formState = EleveState.Create;}
            setState(() {
              widget.disposeOption = value;
              if(value){
                widget.formState = EleveState.Delete;
              }else{
                for (var v in provider.allEleves) {
                  if(v.id == widget.getCp.text){
                    widget.formState = EleveState.Edit;
                    return;
                  }else{
                    if(canClearGetText){
                      canClearGetText = false;
                      
                      widget.getName.text = "";
                      widget.getNickName.text = "";
                      widget.getPicture.text = "";
                    }
                    widget.formState = EleveState.Create;
                  }
                }
              }
            });
          },
        ),
        Center(
          child: form(provider, widget.disposeOption)
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
    }else if(eleveState == EleveState.Delete){
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
    }else{
      return const Text("ERROR");
    }
    
  }
  bool canClearGetText = false;

  Widget form(StudentProvider provider, bool disposeOption){
    if(disposeOption){
      return Form(
        key: widget.form,
        child: SizedBox(
          width: 500,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                controller: widget.getCp,
                decoration: const InputDecoration(
                  label: Text("CP"),
                  hintText: "Ex : cp-00abc"
                ),
                validator: (value) {
                  if(value == null){
                    return "La valeur ne peut pas etre null";
                  }
        
                  if(!value!.contains("-") || !value.contains("cp")){
                    return "La valeur n'est pas juste ! Suivez l'exemple";
                  }

                  for (var v in provider.allEleves) {
                    if(v.id == widget.getCp.text){
                      widget.getName.text = v.name;
                      widget.getNickName.text = v.firstname;
                      widget.getPicture.text = v.photoFilename; 
                      return null;
                    }
                  }
                  return "L'étudiant n'existe pas !!!!";
                },
              ),
              GestureDetector(
                child: sendButton(widget.formState),
                onTap: () {
                  final isValid = widget.form.currentState!.validate();
                  if (!isValid) {
                    return;
                  }

                  Eleve eleve = Eleve(
                    id: widget.getCp.text, 
                    name: widget.getName.text, 
                    firstname: widget.getNickName.text,
                    photoFilename: widget.getPicture.text
                  );

                  provider.removeEleveAndRef(eleve);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('L\'élève à était supprimmé de la liste avec succés!')
                  ));

                  setState(() {
                    widget.getCp.text = "";
                    widget.getName.text = "";
                    widget.getNickName.text = "";
                    widget.getPicture.text = "";
                  });
                },
              ),
            ],
          ),
        ),
      ); 
    }
    return Form(
      key: widget.form,
      child: SizedBox(
        width: 500,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              controller: widget.getCp,
              decoration: const InputDecoration(
                label: Text("CP"),
                hintText: "Ex : cp-00abc"
              ),
              onChanged: (value) {
               if(widget.formState != EleveState.Delete){
                  for (var v in provider.allEleves) {
                    if(v.id == value){
                      setState(() {
                        canClearGetText = true;
                        widget.getName.text = v.name;
                        widget.getNickName.text = v.firstname;
                        widget.getPicture.text = v.photoFilename; 
                        widget.formState = EleveState.Edit;
                      });
                      return;
                    }else{
                      setState(() {
                        if(canClearGetText){
                          canClearGetText = false;

                          widget.getName.text = "";
                          widget.getNickName.text = "";
                          widget.getPicture.text = "";
                        }
                        widget.formState = EleveState.Create;
                      });
                    }
                  }
                }
              },
              validator: (value) {
                if(value == null){
                  return "La valeur ne peut pas etre null";
                }
      
                if(!value!.contains("-") || !value.contains("cp")){
                  return "La valeur n'est pas juste ! Suivez l'exemple";
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.getName,
              decoration: const InputDecoration(
                label: Text("Nom"),
                hintText: "Ex : Doe"
              ),
              validator: (value) {
                if(value == null){
                  return "La valeur ne peut pas être null";
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.getNickName,
              decoration: const InputDecoration(
                label: Text("Prénom"),
                hintText: "Ex : John"
              ),
              validator: (value) {
                if(value == null){
                  return "La valeur ne peut pas être null";
                }
                return null;
              },
            ),
            TextFormField(
              controller: widget.getPicture,
              decoration: const InputDecoration(
                label: Text("Image"),
                hintText: "Ex : https://www.xxx.com/placholder.png"
              ),
            ),
            
            GestureDetector(
              child: sendButton(widget.formState),
              onTap: () {
                final isValid = widget.form.currentState!.validate();
                if (!isValid) {
                  return;
                }
  
                if(widget.getPicture.text.isEmpty){
                  try{
                    widget.getPicture.text = "assets/img/placeholderImage.png";
                  }catch(e){}
                }
  
                final eleve = Eleve(
                  id: widget.getCp.text, 
                  name: widget.getName.text, 
                  firstname: widget.getNickName.text, 
                  photoFilename: widget.getPicture.text
                );
  
                provider.createOrAddOneEleve(eleve);
                setState(() {
                  widget.getCp.text = "";
                  widget.getName.text = "";
                  widget.getNickName.text = "";
                  widget.getPicture.text = "";
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