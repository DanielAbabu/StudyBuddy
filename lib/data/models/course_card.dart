class CourseCard {
  final int id;
  final String date;
  final String title;
  final String? file;

  CourseCard({
    required this.id,
    required this.date,
    required this.title,
    this.file,
  });

  factory CourseCard.fromJson(Map<String, dynamic> json) {
    return CourseCard(
      id: json['id'],
      date: json['created_at'],
      title: json['title'],
      file: json['file'],
    );
  }
}
