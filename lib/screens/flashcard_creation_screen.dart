import 'package:flutter/material.dart';

class FlashcardCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Create Flashcards"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text("Create Flashcards here!"),
      ),
    );
  }
}
