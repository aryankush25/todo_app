class TodoModel {
  String id;
  String content;
  bool isDone;

  TodoModel({
    required this.id,
    required this.content,
    this.isDone = false,
  });

  toggleDone() {
    isDone = !isDone;
  }
}
