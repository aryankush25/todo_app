import 'package:flutter/material.dart';

import '../models/task_model.dart';
import './add_edit_task_sheet.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> taskList;

  final void Function(String id) toggleTask;
  final void Function(String id) deleteTask;
  final void Function({
    required String id,
    String? title,
    String? description,
  }) editTask;

  const TaskList({
    Key? key,
    required this.taskList,
    required this.toggleTask,
    required this.deleteTask,
    required this.editTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              icon: const Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => AddEditTaskSheet(
                    initialText: taskList[index].title,
                    initialDescription: taskList[index].description,
                    deleteTask: () => deleteTask(taskList[index].id),
                    handleSubmit: ({
                      required String title,
                      required String description,
                    }) {
                      editTask(
                        id: taskList[index].id,
                        title: title,
                        description: description,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
