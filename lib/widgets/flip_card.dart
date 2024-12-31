import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Flip_Card extends StatelessWidget {
  final String question;
  final String answer;
  final Key key;

  const Flip_Card({
    required this.question,
    required this.answer,
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
      child: FlipCard(
        key: key,
        front: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: Colors.black.withOpacity(0.3),
          child: Container(
            height: 400,
            width: 310,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        back: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: Colors.black.withOpacity(0.3),
          child: Container(
            height: 400,
            width: 310,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Text(
              answer,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
