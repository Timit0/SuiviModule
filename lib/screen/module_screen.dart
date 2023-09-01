// import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/provider/module_provider.dart';
import 'package:suivi_de_module/widget/module_widget.dart';
import 'package:suivi_de_module/widget/pop_up_module_creation.dart';
import 'package:suivi_de_module/widget/program_action_button.dart';

class ModuleScreen extends StatefulWidget {
  const ModuleScreen({super.key});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<ModuleProvider>(context).fetchAndSetModules();
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

      body: _isLoading ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Padding(
          padding: const EdgeInsets.only(left: 100, right: 100),
          child: ListView.builder(
            itemCount: moduleProvider.modules.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ModuleWidget(
                  nom: moduleProvider.modules[index].nom, 
                  description: moduleProvider.modules[index].description, 
                  horaire: moduleProvider.modules[index].horaire, 
                  classe: moduleProvider.modules[index].classe,
                  eleve: moduleProvider.modules[index].eleve,
                ).buildWidget(context),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          DragTarget(
            builder: (context, candidateData, rejectedData) {
              return const Icon(
                Icons.delete,
                size: 100,
              );
            },
            onAccept: (ModuleWidget data) {
              setState(() {
                
              });
            },
          ),
          ProgramActionButton(func: createModule, icon: Icons.add),
        ] 
      ),
    );
  }

  void createModule(){
    PopUpModuleCreation popUpModuleCreation = PopUpModuleCreation();
    popUpModuleCreation.popUp(context);
    setState(() {
      
    });
  }
}