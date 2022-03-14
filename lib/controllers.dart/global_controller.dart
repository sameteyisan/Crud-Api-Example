import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/helper.dart';
import 'package:task/models/user.dart';
import 'package:task/services/api.dart';

class GlobalController extends GetxController {
  final apiKey = "".obs;
  final search = Rx<String>("");

  TextEditingController apiKeyController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final users = <UserModel>[].obs;

  final isConnect = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();
    apiKey.value = prefs.getString("apiKey") ?? "";
    apiKeyController.text = apiKey.value;
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    final result = await Api.getAllUsers();

    if (result != null) {
      isConnect.value = true;
      users.value = result;
      await SharedPreferences.getInstance().then((value) => {
            value.setString("apiKey", apiKey.value),
          });
      Helper.showToast("Connected");
    } else {
      users.clear();
      isConnect.value = false;
      await SharedPreferences.getInstance().then((value) => value.clear());
      apiKey.value = "";
      Helper.showToast("Error");
    }
    isLoading.value = false;
    Get.back();
  }

  Future<void> deleteUser(String id) async {
    final result = await Api.deleteUser(id);
    if (result != null) {
      users.removeWhere((e) => e.id == id);
      Helper.showToast("User Deleted");
    } else {
      Helper.showToast("Error");
    }
  }
}
