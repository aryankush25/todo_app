import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_list.dart';
import 'package:uuid/uuid.dart';

import '../models/task_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

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

  final titleInputController = TextEditingController();
  final descriptionInputController = TextEditingController();

  void addTask(title, description) {
    setState(() {
      taskList.add(TaskModel(
        id: const Uuid().v1(),
        title: title,
        description: description,
      ));
    });
  }

  void deleteTask(id) {
    setState(() {
      taskList.removeWhere((item) => item.id == id);
    });
  }

  void toggleTask(id) {
    final itemToMarkCompleted = taskList.firstWhere((item) => item.id == id);

    setState(() {
      itemToMarkCompleted.toggleCompleted();
    });
  }

  void editTask(
    id, {
    title,
    description,
  }) {
    final itemToEdit = taskList.firstWhere((item) => item.id == id);

    setState(() {
      if (title) {
        itemToEdit.title = title;
      }
      if (description) {
        itemToEdit.description = description;
      }
    });
  }

  Container addTaskModalBuilder(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.blueGrey.shade50,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Enter details'),
            TextField(
              controller: titleInputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter title',
              ),
            ),
            TextField(
              controller: descriptionInputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter description',
              ),
            ),
            ElevatedButton(
              child: const Text('Done'),
              onPressed: () {
                addTask(
                  titleInputController.text,
                  descriptionInputController.text,
                );

                titleInputController.clear();
                descriptionInputController.clear();

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: addTaskModalBuilder,
          );
        },
        tooltip: 'Add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
