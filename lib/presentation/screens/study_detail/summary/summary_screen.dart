import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../core/constants/app_constants.dart';

class SummaryScreen extends StatelessWidget {
  final String noteContent;

  const SummaryScreen({
    required this.noteContent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.backgroundGrey,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
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
                      'Summary Notes',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    const SizedBox(height: 12),
                    MarkdownBody(
                      data: noteContent.isEmpty
                          ? 'No content available.'
                          : noteContent,
                      styleSheet: MarkdownStyleSheet(
                        h1: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w700, // Bold
                          color: AppConstants.secondaryBlue,
                          height: 1.2,
                        ),
                        h2: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600, // SemiBold
                          color: AppConstants.primaryBlue,
                          height: 1.3,
                        ),
                        h3: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600, // SemiBold
                          color: AppConstants.lightBlue,
                          height: 1.4,
                        ),
                        p: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontWeight: FontWeight.w400, // Regular
                          color: Color.fromARGB(255, 66, 66, 66),
                          height: 1.6,
                        ),
                        strong: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700, // Bold
                          color: Color.fromARGB(255, 32, 32, 32),
                        ),
                        em: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 97, 97, 97),
                        ),
                        blockquote: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 128, 128, 128),
                          backgroundColor: Color.fromARGB(255, 250, 250, 250),
                        ),
                        code: const TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 12,
                          color: AppConstants.primaryBlue,
                          backgroundColor: Color.fromARGB(255, 245, 245, 245),
                          height: 1.5,
                        ),
                        codeblockDecoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        listBullet: const TextStyle(
                          fontFamily: 'OpenSans',
                          color: AppConstants.primaryBlue,
                          fontSize: 14,
                        ),
                        blockSpacing: 10,
                        horizontalRuleDecoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
