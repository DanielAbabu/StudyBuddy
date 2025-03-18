import 'package:flutter/material.dart';

class FlashcardCreationScreen extends StatelessWidget {
  const FlashcardCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Flashcards"),
      ),
      body: const Center(
        child: Text("Create Flashcards here!"),
      ),
    );
  }
}
