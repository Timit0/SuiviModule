import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/enum/stage.dart';
import 'package:suivi_de_module/models/eleve_reference.dart';
import 'package:suivi_de_module/screen/details_student_screen.dart';
import 'package:suivi_de_module/widget/app_bottom_nagiation_bar_widget.dart';

import '../provider/module_provider.dart';
import '../provider/student_provider.dart';
import '../widget/student_card.dart';

class StudentListScreen extends StatefulWidget {
  StudentListScreen({super.key, required this.moduleId});
  String moduleId;

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<StudentProvider>(context, listen: false).fetchAndSetStudents(widget.moduleId);
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: studentProvider.eleves.length,
      itemBuilder: (context, index) {
        return StudentCard(
          eleve: studentProvider.eleves[index], 
          moduleId: widget.moduleId,
          deleteButtonBehavios: () async{
            await studentProvider.removeEleveFromOneModule(studentProvider.eleves[index].id, widget.moduleId);
            setState(() /*async*/ {
              // await Provider.of<ModuleProvider>(context, listen: false).fetchAndSetModules();
            });
          },
          detailButtonBehavior: (){
            setState(() {
              StageScreen.instance.setStageScreen(Stage.eleveDetail);
            });
          },
        ); 
      }
    );
  }
}