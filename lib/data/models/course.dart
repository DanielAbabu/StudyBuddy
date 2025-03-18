class Course {
  final int id;
  final String title;
  final List<List<Map<String, dynamic>>>? questions;
  final List<List<Map<String, dynamic>>>? cards;
  final String noteContent;

  Course({
    required this.id,
    required this.title,
    this.questions,
    this.cards,
    required this.noteContent,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      questions: json['questions'] != null
          ? (json['questions'] as List<dynamic>)
              .map((nestedList) => (nestedList as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList())
              .toList()
          : [],
      cards: json['cards'] != null
          ? (json['cards'] as List<dynamic>)
              .map((nestedList) => (nestedList as List<dynamic>)
                  .map((item) => item as Map<String, dynamic>)
                  .toList())
              .toList()
          : [],
      noteContent: json['note_content'] ?? '',
    );
  }
}
