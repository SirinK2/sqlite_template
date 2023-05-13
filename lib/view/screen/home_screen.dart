import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqlite_template/logic/controller/local_controller.dart';
import 'package:sqlite_template/view/widget/form_dailog.dart';
import 'package:sqlite_template/view/widget/list_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final controller = Get.put(LocalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite Template'),
        elevation: 0,
        actions: [
          MaterialButton(
            onPressed: () async {
              await controller.deleteLocalDatabase();
            },
            child: const Text("DELETE DB"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(FormDialog());
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Container(
          width: Get.width * 0.95,
          height: Get.height,
          padding: const EdgeInsets.all(8),
          child: GetBuilder<LocalController>(builder: (controller) {
            return FutureBuilder(
                future: controller.readData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data?[index];
                          var date = DateFormat('yyyy-MM-dd hh:mm:ss')
                              .parse(data!.date);
                          return ListItem(
                              data: data, date: date, controller: controller);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("THERE IS NO ITEMS"),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text("THERE IS NO ITEMS"),
                    );
                  }
                });
          }),
        ),
      ),
    );
  }
}
