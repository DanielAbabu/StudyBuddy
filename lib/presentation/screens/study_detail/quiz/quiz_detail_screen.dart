import 'package:flutter/material.dart';
import 'package:studybuddy/presentation/screens/study_detail/quiz/quiz_result_screen.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/question_card.dart';

class QuizDetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizDetailScreen({
    required this.questions,
    Key? key,
  }) : super(key: key);

  @override
  _QuizDetailScreenState createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends State<QuizDetailScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;
  Map<int, String?> _userAnswers = {};
  Map<int, bool> _answerCorrectness = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation = AlwaysStoppedAnimation(1 / widget.questions.length);
    _updateProgressAnimation();
  }

  void _updateProgressAnimation() {
    final progress = (_currentPage + 1) / widget.questions.length;
    _progressAnimation = Tween<double>(
      begin: _progressAnimation.value,
      end: progress,
    ).animate(
      CurvedAnimation(
        parent: _progressAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _progressAnimationController.forward(from: 0.0);
  }

  void _nextPage() {
    if (_currentPage < widget.questions.length - 1 &&
        _userAnswers[_currentPage] != null) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == widget.questions.length - 1 &&
        _userAnswers[_currentPage] != null) {
      _showResults();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onAnswerSelected(String answer, bool isCorrect) {
    setState(() {
      _userAnswers[_currentPage] = answer;
      _answerCorrectness[_currentPage] = isCorrect;
    });
  }

  void _showResults() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultsScreen(
          questions: widget.questions,
          userAnswers: _userAnswers,
          answerCorrectness: _answerCorrectness,
        ),
      ),
    );
    if (result == true) {
      setState(() {
        _userAnswers.clear();
        _answerCorrectness.clear();
        _currentPage = 0;
        _pageController.jumpToPage(0);
        _updateProgressAnimation();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quiz',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppConstants.primaryBlue, AppConstants.secondaryBlue],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            onPressed: _userAnswers.isNotEmpty ? _showResults : null,
            tooltip: 'View Results',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_currentPage + 1}/${widget.questions.length}',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            AlwaysStoppedAnimation(AppConstants.primaryBlue),
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _updateProgressAnimation();
                });
              },
              itemCount: widget.questions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppConstants.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Question ${index + 1}',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          child: QuestionCard(
                            key: ValueKey(index),
                            question: widget.questions[index],
                            onAnswerSelected: _onAnswerSelected,
                            initialAnswer: _userAnswers[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavButton(
                  icon: Icons.chevron_left,
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  label: 'Previous',
                ),
                _buildNavButton(
                  icon: Icons.chevron_right,
                  onPressed:
                      _userAnswers[_currentPage] != null ? _nextPage : null,
                  label: _currentPage == widget.questions.length - 1
                      ? 'Finish'
                      : 'Next',
                  isNext: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String label,
    bool isNext = false,
  }) {
    return AnimatedOpacity(
      opacity: onPressed != null ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: AppConstants.primaryBlue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppConstants.primaryBlue.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isNext) Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              if (isNext) const SizedBox(width: 8),
              if (isNext) Icon(icon, color: Colors.white, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
