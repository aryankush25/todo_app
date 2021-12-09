import 'package:flutter/material.dart';
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
  final List<TaskModel> _taskList = [
    TaskModel(
      id: const Uuid().v1(),
      title: 'Make pizza!',
      description: 'Search for recipe on youtube.',
    ),
  ];

  final titleInputController = TextEditingController();
  final descriptionInputController = TextEditingController();

  void _addTask(title, description) {
    setState(() {
      _taskList.add(TaskModel(
        id: const Uuid().v1(),
        title: title,
        description: description,
      ));
    });
  }

  void _deleteTask(id) {
    setState(() {
      _taskList.removeWhere((item) => item.id == id);
    });
  }

  void _toggleTask(id) {
    setState(() {
      final itemToMarkCompleted = _taskList.firstWhere((item) => item.id == id);
      itemToMarkCompleted.toggleCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: taskListBuilder(),
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
                _addTask(
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

  Center taskListBuilder() {
    return Center(
      child: ListView.builder(
        itemCount: _taskList.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: _taskList[index].isCompleted,
            title: Text(_taskList[index].title),
            subtitle: Text(_taskList[index].description),
            onChanged: (value) => _toggleTask(_taskList[index].id),
            secondary: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteTask(_taskList[index].id),
            ),
          );
        },
      ),
    );
  }
}
