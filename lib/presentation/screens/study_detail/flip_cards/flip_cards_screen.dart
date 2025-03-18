import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/course.dart';
import '../../../../data/services/api_service.dart';
import 'flip_cards_detail_screen.dart';

class FlipCardsScreen extends StatefulWidget {
  final Course course;

  const FlipCardsScreen({required this.course, Key? key}) : super(key: key);

  @override
  _FlipCardsScreenState createState() => _FlipCardsScreenState();
}

class _FlipCardsScreenState extends State<FlipCardsScreen>
    with SingleTickerProviderStateMixin {
  late Course course;
  late AnimationController _fabAnimationController;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    course = widget.course;
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  Future<void> _generateCards() async {
    final ApiService apiService = ApiService();
    setState(() => _isGenerating = true);

    try {
      await apiService.generateCard(course.id);
      final updatedCourse = await apiService.fetchCourse(course.id);
      setState(() {
        course = updatedCourse;
        _isGenerating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Cards generated successfully!',
            style: TextStyle(fontFamily: 'Outfit'),
          ),
          backgroundColor: AppConstants.primaryBlue,
        ),
      );
    } catch (error) {
      print("Error generating cards: $error");
      setState(() => _isGenerating = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to generate cards. Try again.',
            style: TextStyle(fontFamily: 'Outfit'),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundGrey,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: course.cards != null && course.cards!.isNotEmpty
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlipCardsDetailScreen(
                                  cards: course.cards![index],
                                ),
                              ),
                            ),
                            child: _buildCoolCard(index),
                          ),
                        );
                      },
                      childCount: course.cards!.length,
                    ),
                  )
                : SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.flip_to_front,
                            size: 80,
                            color: AppConstants.primaryBlue.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No Flip Cards Yet',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Generate some with the button below!',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.2).animate(
          CurvedAnimation(
              parent: _fabAnimationController, curve: Curves.easeInOut),
        ),
        child: FloatingActionButton(
          onPressed: _isGenerating ? null : _generateCards,
          backgroundColor: AppConstants.primaryBlue,
          child: _isGenerating
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : const Icon(Icons.add, color: Colors.white, size: 28),
          elevation: 6,
          tooltip: 'Generate Cards',
        ),
      ),
    );
  }

  Widget _buildCoolCard(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: Matrix4.identity()..translate(0.0, index.isEven ? 0.0 : 4.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryBlue.withOpacity(0.9),
            AppConstants.secondaryBlue.withOpacity(0.7),
          ],
          stops: const [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryBlue.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Set ${index + 1}',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tap to flip and study',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }
}
