import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqlite_template/constant/local_string.dart';
import 'package:sqlite_template/logic/service/local_service.dart';
import 'package:sqlite_template/model/local_model.dart';

class LocalController extends GetxController {
  final localService = LocalService();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  refreshData(){
    readData();
    update();
  }

  clearController(){
   titleController.clear();
   descriptionController.clear();
  }


  // GET DATA
  Future<List<ToDoModel>> readData() async {
    List<Map<String, dynamic>> res = await localService.readData(table: LocalString.tableName);
    return res.map((e) => ToDoModel.fromMap(e)).toList();
  }

  // ADD DATA
  Future<int> insertData(ToDoModel favorite) async {
    return await localService.insertData(
      table: LocalString.tableName,
      values: favorite.toMap(),
    );
  }

  //UPDATE DATA
  Future<int> updateData(ToDoModel toDoModel) async {
    return await localService.updateData(
      table: LocalString.tableName,
      values: toDoModel.toMap(),
      id: toDoModel.id ?? 0,
    );
  }

  //DELETE DATA
  Future<int> deleteData(int? id) async {
    return await localService.deleteData(
      table: LocalString.tableName,
      id: id,
    );
  }

  //delete database
  deleteLocalDatabase() async {
    await localService.deleteLocalDatabase();
    refreshData();
  }
}
