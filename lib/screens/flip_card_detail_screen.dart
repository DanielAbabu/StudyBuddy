import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../widgets/flip_card.dart';

class FlipCardDetailScreen extends StatefulWidget {

  final List<Map<String, String>> cards;

  FlipCardDetailScreen({required this.cards});


  @override
  _FlipCardDetailScreenState createState() => _FlipCardDetailScreenState();
}



class _FlipCardDetailScreenState extends State<FlipCardDetailScreen> {
  // List of question-answer pairs
  // final List<Map<String, String>> cards = [
  //   {'question': 'What is Flutter?', 'answer': 'Flutter is an open-source UI toolkit.'},
  //   {'question': 'What is Dart?', 'answer': 'Dart is a programming language used with Flutter.'},
  //   {'question': 'What is a Widget?', 'answer': 'A widget is a building block of the Flutter UI.'},
  // ];



  int currentIndex = 0;
  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) %  widget.cards.length;
    });
  }

  void previousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 +  widget.cards.length) % widget.cards.length;
    });
  }


  @override
  Widget build(BuildContext context) {
    final currentCard =  widget.cards[currentIndex];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Flip Card Widget
        Flip_Card(
          key: ValueKey(currentIndex), // Assign a unique key to each card
          question: currentCard['question']!,
          answer: currentCard['answer']!,
        ),
        SizedBox(height: 20),
        // Navigation Arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_left, size: 40),
              onPressed: previousCard,
            ),
            IconButton(
              icon: Icon(Icons.arrow_right, size: 40),
              onPressed: nextCard,
            ),
          ],
        ),
      ],
    );
  }
}
