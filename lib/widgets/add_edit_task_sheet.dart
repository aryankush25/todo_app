import 'package:flutter/material.dart';

class AddEditTaskSheet extends StatelessWidget {
  final void Function({
    required String title,
    required String description,
  }) handleSubmit;
  final TextEditingController titleInputController;
  final TextEditingController descriptionInputController;

  AddEditTaskSheet({
    Key? key,
    required this.handleSubmit,
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
          ],
        ),
      ),
    );
  }
}
