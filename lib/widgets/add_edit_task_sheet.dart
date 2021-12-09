import 'package:flutter/material.dart';

class AddEditTaskSheet extends StatelessWidget {
  final void Function({
    required String title,
    required String description,
  }) handleSubmit;
  final void Function()? deleteTask;
  final TextEditingController titleInputController;
  final TextEditingController descriptionInputController;

  AddEditTaskSheet({
    Key? key,
    required this.handleSubmit,
    this.deleteTask,
    initialText = '',
    initialDescription = '',
  })  : titleInputController = TextEditingController(text: initialText),
        descriptionInputController =
            TextEditingController(text: initialDescription),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Done'),
                  onPressed: () {
                    handleSubmit(
                      title: titleInputController.text,
                      description: descriptionInputController.text,
                    );

                    titleInputController.clear();
                    descriptionInputController.clear();

                    Navigator.pop(context);
                  },
                ),
                if (deleteTask != null)
                  ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      deleteTask!();

                      titleInputController.clear();
                      descriptionInputController.clear();

                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
