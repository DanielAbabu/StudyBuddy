import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatelessWidget {

  final List<Map<String, dynamic>> questions;

  QuizScreen({
    required this.questions,
    });


  @override
  Widget build(BuildContext context) {

    return  Container(
        // decoration: BoxDecoration(
        padding: EdgeInsets.all(15),

        child : ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return QuestionCard(question : questions[index]);
          },
        ),
      );
  }
}

