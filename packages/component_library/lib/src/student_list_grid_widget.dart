import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/widget/eleve_card_widget.dart';

class StudentListGridWidget extends StatefulWidget {
  StudentListGridWidget({super.key});

  @override
  State<StudentListGridWidget> createState() => _StudentListGridWidgetState();
}

class _StudentListGridWidgetState extends State<StudentListGridWidget> {

  bool _isInit = true;
  bool _isLoading = false;

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: displayWidget(),
      ),
    );
  }

  Widget displayWidget(){
    final eleveLength = Provider.of<StudentProvider>(context).allEleves.length;
    if(eleveLength > 0){
      return GridView.builder(
        itemCount: eleveLength,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 18,
          crossAxisCount: 5,
          childAspectRatio: 0.8
        ),

        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: EleveCardWidget(eleve: Provider.of<StudentProvider>(context).allEleves[index]),
          );
        },
      );
    }else{
      return const Center(
        child: Text(
          "Aucun élève n'a encore été créer",
          style: TextStyle(
            fontSize: 30
          )
        ),
      );
    }
  }
}