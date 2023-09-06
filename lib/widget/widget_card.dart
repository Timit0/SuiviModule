import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/card_state.dart';
import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/widget/check_widget.dart';

import '../models/test.dart';
import '../provider/test_and_devoir_provider.dart';

class CardWidget extends StatefulWidget {
  CardWidget({super.key, required this.type, required this.name});

  @override
  State<CardWidget> createState() => _CardWidgetState();

  CardState type;
  //String idModule;

  late Color color;

  void setParam(BuildContext context, int index, String moduleId) async {
    //print("SetParam");
    final provider = Provider.of<TestAndDevoirProvider>(context, listen: false);

    // if(type == CardState.Test){
    //   final testId = provider.testsRef[index].id;

    //   Test? test = await provider.getTest(testId, moduleId);
    //   if(test != null){
    //     name = test.nom;
    //   }
    // }

    // if(type == CardState.Devoir){
    //   final devoirId = provider.devoirsRef[index].id;

    //   Devoir? devoir = await provider.getDevoir(devoirId, moduleId);
    //   if(devoir != null){
    //     name = devoir.nom;
    //   }
    // }

    
  }

  late String name;
}

class _CardWidgetState extends State<CardWidget> {



  var _isInit = true;
  var _isLoading = false;


  

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      //await Provider.of<TestAndDevoirProvider>(context).getDevoir(widget.idModule);
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
    widget.color = (widget.type == CardState.Devoir) ? const Color.fromARGB(255, 255, 94, 82) : const Color.fromARGB(255, 142, 255, 146);

    return Card(elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      color: widget.color,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.name),
              //Text("Date"),
            ],
          ),
          Stack(
            children: [
              Positioned(
                right: 0,
                left: 0,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [ 
                              const SizedBox(
                                height: 40,
                                width: 40,
                                child: ColoredBox(
                                  color: Colors.white
                                ),
                              ),
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(
                                  child: CheckWidget(),
                                ),
                              ),
                            ]
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              ),
              const SizedBox(
                height: 250,
                width: 250,
              ),
            ] 
          ),
        ],
      )
    );
  }

  void setParamUwU(int index, String moduleId) async{
    // final provider = Provider.of<TestAndDevoirProvider>(context);

    // if(widget.type == CardState.Test){
    //   final testId = provider.testsRef[index].id;

    //   Test? test = await provider.getTest(testId, moduleId);
    //   if(test != null){
    //     widget.name = test.nom;
    //   }
    // }

    // if(widget.type == CardState.Devoir){
    //   final devoirId = provider.devoirsRef[index].id;

    //   Devoir? devoir = await provider.getDevoir(devoirId, moduleId);
    //   if(devoir != null){
    //     widget.name = devoir.nom;
    //   }
    // }
  }
}