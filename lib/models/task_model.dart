import './todo_model.dart';

class TaskModel {
  String id;
  String title;
  String description;
  bool isCompleted;
  final List<TodoModel> todoList;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.todoList = const <TodoModel>[],
  });

  toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
