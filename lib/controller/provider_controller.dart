
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../model/user_model.dart';
import 'sqflite_controller.dart';

class UserProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<void> addUser(UserModel user) async {
    try {
      await _databaseHelper.insertData(user);
      notifyListeners();
      Get.snackbar(
        "Add Data",
        "successfully!",
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      print("Failed to add user: $e");
      Fluttertoast.showToast(
        msg: "Failed to add user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      return await _databaseHelper.getAllUsers();
    } catch (e) {
      print("Failed to fetch users: $e");
      throw e;
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      await _databaseHelper.deleteUser(userId);
      Get.snackbar(
        "Delete User",
        "successfully!",
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      notifyListeners();
    } catch (e) {
      print("Failed to delete user: $e");
      Fluttertoast.showToast(
        msg: "Failed to delete user: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  Future<void> updateUser(UserModel user) async {
    try {
      await _databaseHelper.updateUser(user);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

}