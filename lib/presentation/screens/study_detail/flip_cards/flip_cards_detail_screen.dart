import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/flip_card.dart';

class FlipCardsDetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cards;

  const FlipCardsDetailScreen({required this.cards, Key? key})
      : super(key: key);

  @override
  _FlipCardsDetailScreenState createState() => _FlipCardsDetailScreenState();
}

class _FlipCardsDetailScreenState extends State<FlipCardsDetailScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation = AlwaysStoppedAnimation(1 / widget.cards.length);
    _updateProgressAnimation();
  }

  void _updateProgressAnimation() {
    final progress = (currentIndex + 1) / widget.cards.length;
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

  void nextCard() {
    if (currentIndex < widget.cards.length - 1) {
      setState(() {
        currentIndex++;
        _updateProgressAnimation();
      });
    }
  }

  void previousCard() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _updateProgressAnimation();
      });
    }
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = widget.cards[currentIndex];

    return Scaffold(
      backgroundColor: AppConstants.backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Flip Cards',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentIndex + 1}/${widget.cards.length}',
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
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Flip_Card(
                    key: ValueKey(currentIndex),
                    question: currentCard['question']!,
                    answer: currentCard['answer']!,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavButton(
                  icon: Icons.chevron_left,
                  onPressed: currentIndex > 0 ? previousCard : null,
                  isLeft: true,
                ),
                _buildNavButton(
                  icon: Icons.chevron_right,
                  onPressed:
                      currentIndex < widget.cards.length - 1 ? nextCard : null,
                  isLeft: false,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool isLeft,
  }) {
    return AnimatedOpacity(
      opacity: onPressed != null ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(12),
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
          child: Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
