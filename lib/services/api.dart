import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task/controllers.dart/global_controller.dart';
import 'package:task/models/create_user.dart';
import 'package:task/models/user.dart';

class Api {
  static Future<List<UserModel>?> getAllUsers() async {
    try {
      Response response = await Dio().get(
          "https://crudcrud.com/api/${Get.find<GlobalController>().apiKey}/users");
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return null;
    } on DioError catch (e) {
      debugPrint('Get all users error : ${e.message}');
      return null;
    }
  }

  static Future<UserModel?> getUser(String id) async {
    try {
      Response response = await Dio().get(
          "https://crudcrud.com/api/${Get.find<GlobalController>().apiKey}/users/$id");
      if (response.statusCode == 200) {
        return response.data == null ? null : UserModel.fromJson(response.data);
      }
      return null;
    } on DioError catch (e) {
      debugPrint('Get user error : ${e.message}');
      return null;
    }
  }

  static Future<bool?> deleteUser(String id) async {
    try {
      Response response = await Dio().delete(
          "https://crudcrud.com/api/${Get.find<GlobalController>().apiKey}/users/$id");
      if (response.statusCode == 200) {
        return true;
      }
      return null;
    } on DioError catch (e) {
      debugPrint('Delete user error : ${e.message}');
      return null;
    }
  }

  static Future<UserModel?> createUser(CreateUserModel createUserModel) async {
    try {
      Response response = await Dio().post(
          "https://crudcrud.com/api/${Get.find<GlobalController>().apiKey}/users",
          data: createUserModel.toJson());
      if (response.statusCode == 201) {
        return response.data == null ? null : UserModel.fromJson(response.data);
      }
      return null;
    } on DioError catch (e) {
      debugPrint('Create user error : ${e.message}');
      return null;
    }
  }

  static Future<bool?> updateUser(String id, CreateUserModel userModel) async {
    try {
      Response response = await Dio().put(
          "https://crudcrud.com/api/${Get.find<GlobalController>().apiKey}/users/$id",
          data: userModel.toJson());
      if (response.statusCode == 200) {
        return true;
      }
      return null;
    } on DioError catch (e) {
      debugPrint('Update user error : ${e.message}');
      return null;
    }
  }
}
