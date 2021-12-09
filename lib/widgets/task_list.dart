import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> taskList;
  final Function toggleTask;
  final Function deleteTask;

  const TaskList({
    Key? key,
    required this.taskList,
    required this.toggleTask,
    required this.deleteTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return taskListBuilder();
  }

  Center taskListBuilder() {
    return Center(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: taskList[index].isCompleted,
            title: Text(taskList[index].title),
            subtitle: Text(taskList[index].description),
            onChanged: (value) => toggleTask(taskList[index].id),
            secondary: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTask(taskList[index].id),
            ),
          );
        },
      ),
    );
  }
}
