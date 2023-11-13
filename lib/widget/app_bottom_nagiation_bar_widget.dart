import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/mode.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/main_screen.dart';
import 'package:suivi_de_module/screen/module_screen.dart';
import 'package:suivi_de_module/screen/student_list_screen.dart';
import 'package:suivi_de_module/widget/module_widget.dart';
import 'package:suivi_de_module/widget/pick_file.dart';

class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({super.key, required this.stage, this.extraBehavior, this.presentationMode});

  Stage stage;

  Function? extraBehavior;
  bool? presentationMode = false;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {

    if (widget.stage == Stage.module)
    {
      return Container(
        height: 90,
        //color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: widget.presentationMode == true ? (){} : () async {
                  ModuleScreen.ResetMode();
                  try {
                    String myFileData = await PickFile.builder() as String;
                    try {
                      await Provider.of<ModuleProvider>(context, listen: false).addModuleFromCsv(myFileData);
                    } catch(e) {
                      await Provider.of<ModuleProvider>(context, listen: false).addModuleFromJson(myFileData);
                    }
                    setState(() {
                      Provider.of<ModuleProvider>(context, listen: false).fetchAndSetModules();
                    });
                  } catch(e) {
                    print(e);
                  }
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_upload,
                      color: Colors.black
                    ),
                    Text('importer un fichier'),
                  ],
                ),
              ),
              InkWell(
                onTap: widget.presentationMode == true ? (){} : () {
                  widget.extraBehavior!.call();
                },
                child: const  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: Colors.black
                    ),
                    Text('ajouter un module'),
                  ],
                ),
              )
            ],
          ),
        )
      // );*/
      );
    }
    else if (widget.stage == Stage.eleves)
    {
      return Container(
        height: 90,
        //color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: widget.presentationMode == true ? (){} : () {
                  StageScreen.instance.setStageScreen(Stage.module);
                  MainScreen.Refresh();
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.view_module,
                      color: Colors.black
                    ),
                    Text('module acceuil'),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: widget.presentationMode == true ? (){} : () {
                      StudentListScreen.Refresh();
                    },
                    child: const  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.black
                        ),
                        Text('Ajouter un élève'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      );
    }else if(widget.stage == Stage.eleveDetail){
      return Container(
        height: 90,
        //color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: widget.presentationMode == true ? (){} : () {
                  StageScreen.instance.setStageScreen(Stage.module);
                  MainScreen.Refresh();
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.view_module,
                      color: Colors.black
                    ),
                    Text('module acceuil'),
                  ],
                ),
              ),
            InkWell(
              onTap: widget.presentationMode == true ? (){} : () async {
                StageScreen.instance.setStageScreen(Stage.eleves);
                ModuleScreen.Refresh();
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list,
                      color: Colors.black
                    ),
                    Text('module list')
                  ],
                ),
              ),
            ),
          ],
        )
      );
    }

    return const Placeholder();
  }
}