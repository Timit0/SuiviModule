import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/eleve.dart';

class StudentCard extends StatelessWidget {
  StudentCard({super.key, required this.eleve});

  final Eleve eleve;

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ClipOval(
          child: CachedNetworkImage(imageUrl: "https://pbs.twimg.com/profile_images/945853318273761280/0U40alJG_400x400.jpg",
            width: 100.0,
            height: 100.0,
            placeholder: (context, url) => Image.asset("assets/img/placeholderImage.png"),
            errorWidget: (context, url, error) => Image.asset("assets/img/errorImage.png"),
          ),
        ),
      ),
      Text(eleve.firstname),
      Text(eleve.name)
    ]));
  }
}
