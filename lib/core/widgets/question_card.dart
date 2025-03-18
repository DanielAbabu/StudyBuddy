import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class QuestionCard extends StatefulWidget {
  final Map<String, dynamic> question;
  final Function(String, bool) onAnswerSelected;
  final String? initialAnswer;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onAnswerSelected,
    this.initialAnswer,
  });

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? selectedAnswer;
  late List<dynamic> answers;

  @override
  void initState() {
    super.initState();
    answers = List<dynamic>.from(widget.question['answers'] ?? []);
    answers.shuffle();
    selectedAnswer = widget.initialAnswer;
  }

  @override
  Widget build(BuildContext context) {
    String questionText =
        widget.question['question_text'] ?? "No question provided";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppConstants.primaryBlue.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionText,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          ...answers.map((answer) {
            String answerText = answer['text'] ?? "No answer text provided";
            bool isCorrect = answer['is_correct'] ?? false;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: selectedAnswer == null
                    ? () {
                        setState(() {
                          selectedAnswer = answerText;
                          widget.onAnswerSelected(answerText, isCorrect);
                        });
                      }
                    : null,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: _getAnswerBackgroundColor(answerText, isCorrect),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _getAnswerBorderColor(answerText, isCorrect),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          answerText,
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _getAnswerTextColor(answerText, isCorrect),
                          ),
                        ),
                      ),
                      if (selectedAnswer == answerText)
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Color _getAnswerBackgroundColor(String answerText, bool isCorrect) {
    if (selectedAnswer == null) return Colors.grey.shade50;
    if (selectedAnswer == answerText) {
      return isCorrect
          ? Colors.green.withOpacity(0.1)
          : Colors.red.withOpacity(0.1);
    }
    return Colors.grey.shade50;
  }

  Color _getAnswerBorderColor(String answerText, bool isCorrect) {
    if (selectedAnswer == null) return Colors.grey.withOpacity(0.2);
    if (selectedAnswer == answerText) {
      return isCorrect
          ? Colors.green.withOpacity(0.5)
          : Colors.red.withOpacity(0.5);
    }
    return Colors.grey.withOpacity(0.2);
  }

  Color _getAnswerTextColor(String answerText, bool isCorrect) {
    if (selectedAnswer == null) return Colors.grey.shade800;
    if (selectedAnswer == answerText) {
      return isCorrect ? Colors.green.shade800 : Colors.red.shade800;
    }
    if (isCorrect) return Colors.green.shade700;
    return Colors.grey.shade800;
  }
}
