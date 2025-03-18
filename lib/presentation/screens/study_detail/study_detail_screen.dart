import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/course.dart';
import '../../../data/services/api_service.dart';
import 'summary/summary_screen.dart';
import 'flip_cards/flip_cards_screen.dart';
import 'quiz/quiz_screen.dart';

class StudyDetailScreen extends StatelessWidget {
  final int id;

  const StudyDetailScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return FutureBuilder<Course>(
      future: apiService.fetchCourse(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppConstants.backgroundGrey,
            body: Center(
              child: CircularProgressIndicator(
                color: AppConstants.primaryBlue,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: AppConstants.backgroundGrey,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final course = snapshot.data!;

          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: AppConstants.backgroundGrey,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  course.title,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                  ),
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Summary'),
                    Tab(text: 'Flip Card'),
                    Tab(text: 'Questions'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SummaryScreen(noteContent: course.noteContent),
                  FlipCardsScreen(course: course),
                  QuizScreen(course: course),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: AppConstants.backgroundGrey,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Course not found with ID: $id',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
