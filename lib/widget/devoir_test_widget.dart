import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/card_state.dart';
import 'package:suivi_de_module/models/devoir.dart';
import 'package:suivi_de_module/models/test.dart';
import 'package:suivi_de_module/provider/devoir_provider.dart';
import 'package:suivi_de_module/provider/test_provider.dart';
import 'package:suivi_de_module/widget/list_of_widget.dart';


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

  // false -> ajout d'un devoir/test
  // true -> supression d'un devoir/test
  bool mode = false;

  final _formKey = GlobalKey<FormState>();

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    
    if (_isInit)
    {
      _isLoading = true;

      await Provider.of<DevorProvider>(context, listen: false).fetchAndSetDevoirs(widget.args.toString());    
      await Provider.of<TestProvider>(context, listen: false).fetchAndSetTests(widget.args.toString());

      setState(() {
        _isLoading = false;
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  AlertDialog additionDialog(CardState type)
  {
    return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${mode ? 'Ajout' : 'Suppression'} d\'un ${type == CardState.Devoir ? 'devoir' : 'Test'}', textAlign: TextAlign.left),
                Switch(
                  value: mode,
                  activeTrackColor: Colors.grey,
                  inactiveTrackColor: Colors.white,
                  onChanged: (value) => setState(() {
                    mode = !mode;
                    value = mode;
                  })
                ),
                IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, color: Colors.red))
              ],
            ),
            scrollable: true,
            content: Form(key: _formKey, child: SizedBox(
              height: 700,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.end,children: [
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
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.end,children: [
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
                ],),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: ElevatedButton(style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith((states) => const Color.fromARGB(255, 126, 126, 126))),
                    onPressed: (){
                      if (_formKey.currentState!.validate())
                      {
                        widget.tempDateTime ??= DateTime.now();
                        _formKey.currentState!.save();
                
                        if (type == CardState.Devoir)
                        {
                          // ajout de devoirs
                          Provider.of<DevorProvider>(context, listen: false).createDevoir(Devoir(
                            id: widget.tempID!,
                            nom: widget.tempName!, description: widget.tempDescription!, 
                            date: widget.tempDateTime!.toString()
                          ),widget.args as String);
                        }
                        else
                        {
                          Provider.of<TestProvider>(context, listen: false).createTest(Test(
                            id: widget.tempID!, 
                            nom: widget.tempName!, 
                            description: widget.tempDescription!, 
                            date: widget.tempDateTime!.toString()
                          ), widget.args as String);
                        }
                          
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Le ${type == CardState.Devoir ? 'devoir' : 'test'} à était ajouté avec succés')
                          ));
                      }
                  }, child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ajouter', style: TextStyle(color: Colors.white, fontSize: 20)),
                  )),
                )
              ]),
            ))
          );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 80, right: 80, bottom: 100),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Devoirs', textAlign: TextAlign.left, style: TextStyle(fontSize: 40)),
        ),
        ListOfWidget(
          objects: Provider.of<DevorProvider>(context).devoirs,
          additionDialog: additionDialog(CardState.Devoir),
          type: CardState.Devoir,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text('Tests', textAlign: TextAlign.left, style: TextStyle(fontSize: 40)),
        ),
        ListOfWidget(
          objects: Provider.of<TestProvider>(context).tests,
          additionDialog: additionDialog(CardState.Test),
          type: CardState.Test,
        )
      ]),
    );
  }
}