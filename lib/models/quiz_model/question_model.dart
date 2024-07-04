class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({required this.id, required this.title, required this.options});

//to print the question on console
  @override
  String toString() {
    // TODO: implement toString
    return 'quiz(id: $id, title: $title, options: $options)';
  }
}
