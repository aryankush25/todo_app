class TodoModel {
  String id;
  String content;
  bool isDone;

  TodoModel({
    required this.id,
    required this.content,
    required this.isDone,
  });

  toggleDone() {
    isDone = !isDone;
  }
}
