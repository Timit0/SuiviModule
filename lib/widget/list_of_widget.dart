import 'package:flutter/material.dart';
import 'package:suivi_de_module/widget/widget_card.dart';
import 'add_card_widget.dart';

class ListOfWidget extends StatelessWidget {
  ListOfWidget({
    super.key, 
    required this.widget, 
    required this.controller, 
    required this.varDebug, 
    required this.paddingList, 
    this.additionDialog
  });

  Widget widget;
  ScrollController controller;
  int varDebug; // ?
  double paddingList;
  AlertDialog? additionDialog; // <- pété mais si on faisait autrement, il aurait pleurniché

  @override
  Widget build(BuildContext context) {
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
                  return AddCardWidget(dialog: additionDialog, type: (widget as CardWidget).type);
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
}