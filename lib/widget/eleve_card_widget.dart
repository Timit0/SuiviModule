import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/provider/student_provider.dart';

class EleveCardWidget extends StatelessWidget {

  late Eleve eleve;

  EleveCardWidget({super.key, required this.eleve});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 199, 199, 199),
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
                    title: Text('Êtes - vous sûre de vouloir supprimer ${eleve.id}?'),
                    content: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      TextButton(onPressed: (){
                        Provider.of<StudentProvider>(context, listen: false).removeEleveAndRef(eleve);
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
            imageUrl: eleve.photoFilename, 
            errorWidget: (context, url, error) => const Icon(Icons.person_rounded, size: 50,),
            placeholder: (context, url) => Image.asset('assets/img/placeholerImage.png'),
            width: 100,
          ),
        ),
        Text(eleve.id),
        Text("${eleve.firstname} ${eleve.name}")
      ]),
    );
  }
}