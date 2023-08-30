import 'dart:ui';

import 'package:flutter/material.dart';


enum CardState {
  Test,
  Devoir,
}


class DetailsStudentScreen extends StatefulWidget {
  const DetailsStudentScreen({super.key});

  static const routeName = '/details_student_screen';

  @override
  State<DetailsStudentScreen> createState() => _DetailsStudentScreenState();
}

class _DetailsStudentScreenState extends State<DetailsStudentScreen> {
  @override
  Widget build(BuildContext context) {

    final ScrollController controllerDevoir = ScrollController();
    final ScrollController controllerTest = ScrollController();
    final varDebug = 8;
    double paddingList = 50;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Devoir - Test",
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Row(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children:[ 
                  SizedBox(
                    height: MediaQuery.of(context).size.height - AppBar().preferredSize.height,
                    width: 400,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 80, 80, 80),
                            Colors.grey
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    child: Column(
                      children: [
                      
                        Center(
                          child: avatar(),
                        ),
                        Text(
                          "Ogan",
                          style: TextStyle(
                            fontSize: 45
                          ),
                        ),
                        Text(
                          "Ozkul",
                          style: TextStyle(
                            fontSize: 25
                          ),
                        ),

                        moyennneWidget(),
                      ], 
                    ),
                  ),
                ]
              ),
            ]
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                          width: 2
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2
                        )
                      )
                    ),
                    child: const Text(
                      "347",
                      style: TextStyle(
                        fontSize: 50
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: paddingList),
                      child: const Text(
                        "Devoirs",
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                    ),
                    listOf(widgetCard(CardState.Devoir), controllerDevoir, varDebug, paddingList),
                    
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: paddingList),
                      child: const Text(
                        "Tests",
                        style: TextStyle(
                          fontSize: 30
                        ),
                      ),
                    ),
                    listOf(widgetCard(CardState.Test), controllerTest, varDebug, paddingList),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget listOf(Widget widget, ScrollController controller, int varDebug, double paddingList){
    return Padding(
      padding: EdgeInsets.only(left: paddingList, right: paddingList),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Scrollbar(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListView.builder(
              controller: controller,
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              //padding: const EdgeInsets.all(15),
              itemCount: varDebug,
              itemBuilder: (context, index) {
                if(index + 1 == varDebug){
                  return addCard();
                }else{
                  return widget;
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetCard(CardState cardState){
    late Color color;
    if(cardState == CardState.Devoir){
      color = const Color.fromARGB(255, 255, 94, 82);
    }else{
      color = const Color.fromARGB(255, 142, 255, 146);
    }
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      color: color,
      child: Stack(
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
                    padding: EdgeInsets.all(8.0),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [ 
                          SizedBox(
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
                              child: checkWidget(),
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
          SizedBox(
            height: 250,
            width: 250,
          ),
        ] 
      ),
    );
  }

  Widget checkWidget(){
    bool checkState = false;
    return GestureDetector(
      onTap: () {
        if(checkState){
          checkState = false;
        }else{
          checkState = true;
        }
        print("Clik : "+checkState.toString());
        setState(() {
          
        });
      },
      child: SizedBox(
        height: 40,
        width: 40,
        child: Center(
          child: isChecked(checkState)
        ),
      ),
    );
  }

  Widget? isChecked(bool b){
    if(b){
      return Icon(
        Icons.check,
        size: 40,
      );
    }else{
      return ClipOval(
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.abc),
        ),
      );
    }

  }

  Widget avatar(){
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipOval(
            child: SizedBox(
              height: 210,
              width: 210,
              child: ColoredBox(color: 
              Colors.black
              ),
            ),
          ),
          ClipOval(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: ColoredBox(color: Colors.white),
                  ),
                  Image.network("https://upload.wikimedia.org/wikipedia/fr/thumb/a/a1/Logo_FC_Barcelona.svg/800px-Logo_FC_Barcelona.svg.png"),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }

  Widget addCard(){
    return Card(
      elevation: 4,
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 230,
            width: 230,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              color: const Color.fromARGB(255, 201, 201, 201),
              child: SizedBox(
                width: 230,
                height: 230,
              ),
            ),
          ),
          Icon(
            Icons.add,
            size: 100,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget moyennneWidget(){
    double border = 7;
    return Padding(
      padding: const EdgeInsets.only(top: 75),
      child: Container(
        alignment: Alignment.center,
        height: 180,
        width: 100,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black,
              width: border,
            ),
            bottom: BorderSide(
              color: Colors.black,
              width: border,
            ),
          )
        ),

        child: Text(
          "6",
          style: TextStyle(
            fontSize: 115
          ),
        ),
      ),
    );
  }
}