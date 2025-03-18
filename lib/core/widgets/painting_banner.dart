import 'package:flutter/material.dart';
import 'package:studybuddy/data/models/course_card.dart';
import 'package:studybuddy/data/services/api_service.dart';
import 'package:studybuddy/presentation/screens/upload/upload_screen.dart';

class PaintingBanner extends StatefulWidget {
  const PaintingBanner({Key? key}) : super(key: key);

  @override
  _PaintingBannerState createState() => _PaintingBannerState();
}

class _PaintingBannerState extends State<PaintingBanner> {
  final ApiService apiService = ApiService();
  late Future<List<CourseCard>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = apiService.fetchAllCourses();
  }

  Future<void> _refreshCourses() async {
    setState(() {
      _coursesFuture = apiService.fetchAllCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue[500],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: 40,
                child: _buildCloud(70, 30, Colors.blue[300]!.withOpacity(0.4)),
              ),
              Positioned(
                top: 10,
                left: 70,
                child: _buildCloud(50, 30, Colors.blue[300]!.withOpacity(0.3)),
              ),
              Positioned(
                bottom: 20,
                right: 80,
                child: _buildCloud(80, 40, Colors.blue[300]!.withOpacity(0.6)),
              ),
              Positioned(
                top: 40,
                right: 30,
                child: _buildCloud(60, 30, Colors.blue[300]!.withOpacity(0.6)),
              ),
              Positioned(
                bottom: 10,
                left: 120,
                child: _buildCloud(50, 25, Colors.blue[300]!.withOpacity(0.7)),
              ),
              Positioned(
                top: 0,
                bottom: 40,
                left: 30,
                child: const Center(
                  child: Text(
                    'Start\nStudying',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    height: 10,
                    width: 120,
                    child: Image.asset(
                      'images/lady.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 24,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Material(
                    color: Colors.blue[500],
                    borderRadius: BorderRadius.circular(50),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadScreen()))
                            .then((_) => _refreshCourses());
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Create a Set',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloud(double width, double height, Color color) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
