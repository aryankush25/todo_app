import '../models/todo_model.dart';

class TaskModel {
  String id;
  String title;
  String description;
  bool isCompleted;
  List<TodoModel> todoList;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.todoList,
  });

  toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
