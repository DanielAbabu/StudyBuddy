class CourseEntity {
  final int id;
  // final String date;
  final String title;
  final List<Map<String, dynamic>>? questions;
  final List<Map<String, String>>? cards;
  final String noteContent;

  CourseEntity({
    required this.id,
    // required this.date,
    required this.title,
    required this.questions,
    required this.cards,
    required this.noteContent,
  });

  factory CourseEntity.fromJson(Map<String, dynamic> json) {
    return CourseEntity(
      id: json['id'],
      // date: json['created_at'],
      title: json['title'],
      questions: List<Map<String, dynamic>>.from(json['questions']),
      cards: List<Map<String, String>>.from(json['cards']),
      noteContent: json['note_content'],
    );
  }
}


class CourseCardEntity {
  final int id;
  final String date;
  final String title;
  final String? file;


  CourseCardEntity({
    required this.id,
    required this.date,
    required this.title,
    required this.file

  });

  factory CourseCardEntity.fromJson(Map<String, dynamic> json) {
    return CourseCardEntity(
      id: json['id'],
      date: json['created_at'],
      title: json['title'],
      file: json['file'],

    );
  }
}
