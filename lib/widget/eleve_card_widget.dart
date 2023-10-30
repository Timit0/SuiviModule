import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/global/eleve_gestion_form_global.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/widget/eleve_gestion_form.dart';
import 'package:suivi_de_module/widget/student_list_grid_widget.dart';

class EleveCardWidget extends StatefulWidget {

  late Eleve eleve;

  EleveCardWidget({super.key, required this.eleve});

  @override
  State<EleveCardWidget> createState() => _EleveCardWidgetState();
  static void Refresh(){
    _refreshCode!.call();
  }

  static Function? _refreshCode;
}

class _EleveCardWidgetState extends State<EleveCardWidget> {
  Color changeColors(){
    return widget.eleve.id == EleveGestionFormGlobal.cp ?Color.fromARGB(255, 255, 134, 134) : const Color.fromARGB(255, 199, 199, 199);
  }


  @override
  Widget build(BuildContext context) {
    EleveCardWidget._refreshCode = (){
      setState(() {
      });
    };

    return InkWell(
      onTap: () {
        EleveCardWidget.Refresh();
        if(EleveGestionFormGlobal.cp == widget.eleve.id && widget.eleve.id != ""){
          EleveGestionFormGlobal.isFocusOnEleve = false;
        }else{
          EleveGestionFormGlobal.isFocusOnEleve = true;
        }

        if(EleveGestionFormGlobal.isFocusOnEleve){
          EleveGestionFormGlobal.update(widget.eleve);
        }else{
          EleveGestionFormGlobal.reset();
        }
        EleveGestionForm.Refresh();

        setState(() {
          
        });
      },
      child: Container(
        color: changeColors(),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(),
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Êtes - vous sûre de vouloir supprimer ${widget.eleve.id}?'),
                      content: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        TextButton(onPressed: (){
                          Provider.of<StudentProvider>(context, listen: false).removeEleveAndRef(widget.eleve);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('L\'élève à était supprimé avvec succés')
                            )
                          );
                          Navigator.of(context).pop();
                        }, child: const Text('Oui')),
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                        }, child: const Text('Non')),
                      ]),
                    ),
                  );
                }, 
                icon: const Icon(Icons.close, color: Colors.red)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 18.0),
            child: CachedNetworkImage(
              imageUrl: widget.eleve.photoFilename, 
              errorWidget: (context, url, error) => const Icon(Icons.person_rounded, size: 50,),
              placeholder: (context, url) => Image.asset('assets/img/placeholerImage.png'),
              width: 100,
            ),
          ),
          Text(widget.eleve.id),
          Text("${widget.eleve.firstname} ${widget.eleve.name}")
        ]),
      ),
    );
  }
}