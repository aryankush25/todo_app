import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './add_edit_task_sheet.dart';
import './task_list.dart';
import '../models/task_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TaskModel> taskList = [
    TaskModel(
      id: const Uuid().v1(),
      title: 'Make pizza!',
      description: 'Search for recipe on youtube.',
    ),
  ];

  void addTask(String title, String description) {
    setState(() {
      taskList.add(TaskModel(
        id: const Uuid().v1(),
        title: title,
        description: description,
      ));
    });
  }

  void deleteTask(String id) {
    setState(() {
      taskList.removeWhere((item) => item.id == id);
    });
  }

  void toggleTask(String id) {
    final itemToMarkCompleted = taskList.firstWhere((item) => item.id == id);

    setState(() {
      itemToMarkCompleted.toggleCompleted();
    });
  }

  void editTask({
    required String id,
    String? title,
    String? description,
  }) {
    final itemToEdit = taskList.firstWhere((item) => item.id == id);

    setState(() {
      if (title != null) {
        itemToEdit.title = title;
      }
      if (description != null) {
        itemToEdit.description = description;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TaskList(
        taskList: taskList,
        toggleTask: toggleTask,
        deleteTask: deleteTask,
        editTask: editTask,
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (ctx) => AddEditTaskSheet(
            handleSubmit: ({
              required String title,
              required String description,
            }) {
              addTask(
                title,
                description,
              );
            },
          ),
        );
      },
      tooltip: 'Add task',
      child: const Icon(Icons.add),
    );
  }
}
