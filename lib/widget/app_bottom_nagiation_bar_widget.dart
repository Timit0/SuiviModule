import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/screen/main_screen.dart';
import 'package:suivi_de_module/widget/pick_file.dart';

class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({super.key, required this.stage});

  Stage stage;

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
        color: Colors.white,
        child: InkWell(
          onTap: () async {
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
          child: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Icon(
                  Icons.file_upload,
                  color: Colors.black
                ),
                Text('Importer un fichier')
              ],
            ),
          ),
        )
      );
    }
    else if (widget.stage == Stage.eleves)
    {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Retour'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Ajouter un eleve')
        ],
        onTap: (value) {
          if (value == 0)
          {
            StageScreen.instance.setStageScreen(Stage.module);
            MainScreen.Refresh();
          }
        },
      );
    }

    return const Placeholder();
  }
}