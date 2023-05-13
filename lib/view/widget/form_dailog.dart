import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlite_template/logic/controller/local_controller.dart';
import 'package:sqlite_template/model/local_model.dart';

class FormDialog extends StatelessWidget {
  FormDialog({Key? key}) : super(key: key);
  final controller = Get.put(LocalController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add item'),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: controller.descriptionController,
              decoration:
                  const InputDecoration(hintText: 'Description'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Save', style: TextStyle(color: Colors.black),),
          onPressed: () async {
            Get.back();
            //add func
            var data = ToDoModel(
              title: controller.titleController.text,
              description: controller.descriptionController.text,
              date: DateTime.now().toString(),
            );
            await controller.insertData(data);
            controller.refreshData();
            controller.clearController();

          },
        ),
      ],
    );
  }
}
