import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../entity/entities.dart';

const String baseApiUrl = "https://d919c9ad-25ba-46cf-89de-81a8039fcaaa.mock.pstmn.io";

class ApiService {
  Future<List<CourseCardEntity>> fetchAllCourses() async {
    final url = Uri.parse('$baseApiUrl/courses');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
          // Parse the JSON response
          final Map<String, dynamic> responseData = json.decode(response.body);

          // Extract the 'courses' list
          final List<dynamic> coursesJson = responseData['courses'];

          // Map JSON objects to CourseCardEntity instances
          final courses = coursesJson
              .map((courseJson) => CourseCardEntity.fromJson(courseJson))
              .toList();

          return courses;

      } else {
        throw Exception('Failed to load all courses. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load all courses: $error');
    }
  }

  Future<CourseEntity> fetchCourse(String courseid) async {
    final url = Uri.parse('$baseApiUrl/courses/$courseid');

    try {
      final response = await http.get(url);
      // print(response);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(responseData);

        return CourseEntity.fromJson(responseData["course"]);
      } else {
        throw Exception('Failed to load course with ID: $courseid. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load course with ID: $courseid: $error');
    }
  }
}
