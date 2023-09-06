import 'package:flutter/material.dart';
import 'package:suivi_de_module/infrastructure/firebase_db_service.dart';
import 'package:suivi_de_module/models/card_state.dart';
import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/models/module.dart';
import 'package:suivi_de_module/widget/list_of_widget.dart';
import 'package:suivi_de_module/widget/add_card_widget.dart';
import 'package:suivi_de_module/widget/widget_card.dart';

class DevoirTestWidget extends StatefulWidget {
  DevoirTestWidget({super.key, required this.args});

  DateTime? tempDateTime;

  String? tempName;
  String? tempID;
  String? tempDescription;

  final args;

  @override
  State<DevoirTestWidget> createState() => _DevoirTestWidgetState();
}

class _DevoirTestWidgetState extends State<DevoirTestWidget> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final ScrollController controllerDevoir = ScrollController();
    final ScrollController controllerTest = ScrollController();

    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80, bottom: 100),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 45),
          child: Text('Devoirs', textAlign: TextAlign.left, style: TextStyle(fontSize: 40)),
        ),
        ListOfWidget(
          widget: CardWidget(type: CardState.Devoir), 
          controller: controllerDevoir, 
          varDebug: 8, 
          paddingList: 50,
          additionDialog: AlertDialog(
            title: const Text('Ajout d\'un devoir'),
            scrollable: true,
            content: Form(key: _formKey, child: Column(children: [
              Row(children: [
                const Text('Identifiant'),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      validator: (value) => value == "" ? "Il faut que l'identifiant soit rempli!" : null,
                      onSaved: (newValue) => widget.tempID = newValue as String,
                    ),
                  ),
                )
              ]),
              Row(children: [
                const Text('Nom'),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      validator: (value) => value == "" ? "Il faut que le nom soit rempli!" : null,
                      onSaved: (newValue) => widget.tempName = newValue as String,
                    ),
                  ),
                )
              ]),
              Row(children: [
                const Text('description'),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: TextFormField(
                      autocorrect: false,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      maxLines: 255,
                      validator: (value) => value == "" ? "Il faut que la description soit rempli!" : null,
                      onSaved: (newValue) => widget.tempDescription = newValue as String,
                    ),
                  ),
                )
              ]),
                Row(children: [
                const Text('date'),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 300,
                    child: TextButton(
                      onPressed: () async {
                        widget.tempDateTime = await showDatePicker(
                        context: context, 
                        initialDate: DateTime.now(), 
                        firstDate: DateTime.now(), 
                        lastDate: DateTime(9999),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,

                      );}, child: Text(DateTime.now().toString())
                    )
                  ),
                )
              ]),
              ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate())
                {
                  widget.tempDateTime ??= DateTime.now();
                  _formKey.currentState!.save();

                  // ajout de devoirs
                  FirebaseDBService.instance.addDevoir(Devoir(
                    id: widget.tempID!,
                    nom: widget.tempName!, description: widget.tempDescription!, 
                    date: widget.tempDateTime!.toString()
                    ),widget.args as String);
                    
                    Navigator.of(context).pop();
                }
              }, child: const Text('Ajouter!'))
            ]))
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 45),
          child: Text('Tests', textAlign: TextAlign.left, style: TextStyle(fontSize: 40)),
        ),
        ListOfWidget(
          widget: CardWidget(type: CardState.Test), 
          controller: controllerTest, 
          varDebug: 8, 
          paddingList: 50
        )
      ]),
    );
  }
}