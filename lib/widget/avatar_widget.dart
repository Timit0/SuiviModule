import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  AvatarWidget({super.key, required this.photoUrl});

  String photoUrl;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const ClipOval(
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
                  const SizedBox.expand(
                    child: ColoredBox(color: Colors.white),
                  ),
                  //Image.network("https://upload.wikimedia.org/wikipedia/fr/thumb/a/a1/Logo_FC_Barcelona.svg/800px-Logo_FC_Barcelona.svg.png"),
                  CachedNetworkImage(imageUrl: widget.photoUrl, errorWidget: (context, url, error) => Image.asset('assets/img/errorImage.png'), placeholder: (context, url) => Image.asset('assets/img/placeholderImage.png'))
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}