import 'package:flutter/material.dart';
import 'package:suivi_de_module/models/card_state.dart';
import 'package:suivi_de_module/widget/check_widget.dart';

class CardWidget extends StatefulWidget {
  CardWidget({super.key, required this.type});

  @override
  State<CardWidget> createState() => _CardWidgetState();

  CardState type;

  late Color color;
}

class _CardWidgetState extends State<CardWidget> {

  @override
  Widget build(BuildContext context) {

    widget.color = (widget.type == CardState.Devoir) ? const Color.fromARGB(255, 255, 94, 82) : const Color.fromARGB(255, 142, 255, 146);

    return Card(elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      color: widget.color,
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
      ));
  }
}