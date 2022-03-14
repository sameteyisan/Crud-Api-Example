import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task/controllers.dart/global_controller.dart';
import 'package:task/helper.dart';
import 'package:task/model_parser.dart';
import 'package:task/models/create_user.dart';
import 'package:task/models/user.dart';
import 'package:task/services/api.dart';

class FormController extends GetxController {
  final dateNow = DateTime.now();
  final current = DateTime(2000, 9, 9).obs;

  TextEditingController username = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController birthday = TextEditingController();
  @override
  void onInit() {
    imageUrl.text =
        "https://shellix.com/wp-content/uploads/2020/10/Shellix-About-1-768x768.png";
    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    imageUrl.dispose();
    birthday.dispose();
    super.onClose();
  }

  void setDate(DateTime _date) {
    current(_date);
    birthday.text = ModelParser.dayTime(_date);
  }

  Future<void> createUser() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final globalController = Get.find<GlobalController>();
    CreateUserModel usermodel = CreateUserModel(
      name: username.text,
      image: imageUrl.text,
      birthday: current.value,
    );
    final user = await Api.createUser(usermodel);
    EasyLoading.dismiss();
    if (user != null) {
      globalController.users.add(user);
      Helper.showToast("User Created");
    } else {
      Helper.showToast("Error");
    }
    Get.back();
  }

  Future<void> updateUser(UserModel userModel) async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    final result = await Api.updateUser(
        userModel.id,
        CreateUserModel(
            name: userModel.name,
            image: userModel.image,
            birthday: userModel.birthday));
    if (result != null) {
      final globalController = Get.find<GlobalController>();
      final user =
          globalController.users.firstWhere((e) => e.id == userModel.id);
      user.name = userModel.name;
      user.image = userModel.image;
      user.birthday = userModel.birthday;
      globalController.users.refresh();
      EasyLoading.dismiss();
      Helper.showToast("User Updated");
    } else {
      Helper.showToast("Error");
    }
    Get.back();
  }
}
