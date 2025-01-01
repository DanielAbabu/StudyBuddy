import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/question_card.dart';


class QuizDetailScreen extends StatelessWidget {

  final List<Map<String, dynamic>> questions;

  QuizDetailScreen({
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

