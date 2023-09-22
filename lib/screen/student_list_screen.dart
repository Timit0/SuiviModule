import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      print("Fetch : ${widget.moduleId}");
      await Provider.of<StudentProvider>(context, listen: false).fetchAndSetStudents(widget.moduleId);
      print("Set : "+StudentProvider.instance.eleves.length.toString());
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("Call");
    return _isLoading ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
        shrinkWrap: true,
        itemCount: StudentProvider.instance.eleves.length,
        itemBuilder: (context, index) {
          print("Eleve : "+StudentProvider.instance.eleves.length.toString());
          return StudentCard(
            eleve: StudentProvider.instance.eleves[index], 
            moduleId: widget.moduleId,
            deleteButtonBehavios: (){
              //Provider.of<ModuleProvider>(context).
            },
            detailButtonBehavior: (){
              
              // selectedEleve = StudentProvider.instance.eleves[index];

              // setState(() {
              //   level = Stage.eleveDetail;
              // });
            },
          ); 
        }
      );
    //return Text("Test");
  }
}