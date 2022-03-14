import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:task/controllers.dart/form_controller.dart';
import 'package:task/controllers.dart/global_controller.dart';
import 'package:task/helper.dart';
import 'package:task/model_parser.dart';
import 'package:task/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBasicModal extends GetView<GlobalController> {
  const CustomBasicModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "ENTER API KEY",
        style: TextStyle(color: Colors.black, letterSpacing: 2),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            labelText: "Api Key",
            hintText: "Please Enter",
            controller: controller.apiKeyController,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: CustomInkWell(
              onTap: () async => await launch("https://crudcrud.com/"),
              child: const Text(
                "Click for Api Key",
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.apiKey.value = controller.apiKeyController.text;
              controller.fetchUsers();
            },
            child: const Text("Connect"))
      ],
    );
  }
}

class CustomCreateUserModal extends StatelessWidget {
  const CustomCreateUserModal({
    Key? key,
    this.isUpdate = false,
    this.userModel,
  }) : super(key: key);

  final bool? isUpdate;
  final UserModel? userModel;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FormController());
    if (isUpdate == true && userModel != null) {
      controller.username.text = userModel!.name;
      controller.imageUrl.text = userModel!.image;
      controller.current.value = userModel!.birthday;
      controller.birthday.text = ModelParser.dayTime(userModel!.birthday);
    }
    return AlertDialog(
      title: const Text(
        "CREATE USER",
        style: TextStyle(color: Colors.black, letterSpacing: 2),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
                labelText: "Name",
                hintText: "Enter Name",
                controller: controller.username),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Image Url",
              labelText: "Image",
              controller: controller.imageUrl,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              hintText: "Select Birthday",
              labelText: "Birthday",
              readOnly: true,
              controller: controller.birthday,
              onTap: () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  maxTime: controller.dateNow,
                  onConfirm: controller.setDate,
                  currentTime: controller.current.value,
                  theme: const DatePickerTheme(
                    doneStyle: TextStyle(color: Colors.teal, fontSize: 16),
                    cancelStyle: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: Get.back,
                  child: const Text("Cancel")),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    if (isUpdate == true && userModel != null) {
                      controller.updateUser(UserModel(
                          id: userModel!.id,
                          name: controller.username.text,
                          image: controller.imageUrl.text,
                          birthday: controller.current.value));
                    } else {
                      controller.createUser();
                    }
                  },
                  child: Text(isUpdate == true ? "Update" : "Create")),
            ),
          ],
        ),
      ],
    );
  }
}
