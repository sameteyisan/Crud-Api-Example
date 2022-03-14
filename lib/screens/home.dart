import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task/controllers.dart/global_controller.dart';
import 'package:task/helper.dart';
import 'package:task/utils.dart';

class HomePage extends GetView<GlobalController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() => FloatingActionButton(
                  elevation: 0,
                  backgroundColor:
                      controller.isConnect.value ? Colors.teal : Colors.red,
                  mini: true,
                  heroTag: 1,
                  onPressed: () => Get.dialog(const CustomBasicModal())
                      .whenComplete(() => controller.apiKeyController.text =
                          controller.apiKey.value),
                  child: const Icon(
                    FontAwesomeIcons.connectdevelop,
                  ))),
              const SizedBox(height: 16),
              Obx(
                () => FloatingActionButton(
                    elevation: 0,
                    backgroundColor:
                        controller.isConnect.value ? Colors.teal : Colors.grey,
                    heroTag: 2,
                    onPressed: controller.isConnect.value
                        ? () async => Get.dialog(const CustomCreateUserModal())
                        : null,
                    child: const Icon(FontAwesomeIcons.plus)),
              )
            ],
          ),
          appBar: AppBar(
            title: const Text("Crud API Example"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.teal,
          ),
          body: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.users.isNotEmpty
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(FontAwesomeIcons.search),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: CustomTextField(
                                    controller: controller.searchController,
                                    hintText: "Search Anything",
                                    onChanged: (search) =>
                                        controller.search.value = search.trim(),
                                    suffixIcon: IconButton(
                                        splashRadius: 20,
                                        icon:
                                            const Icon(FontAwesomeIcons.times),
                                        onPressed: () {
                                          controller.searchController.clear();
                                          controller.search.value = "";
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                children: controller.users
                                    .where((p0) => p0.name
                                        .toLowerCase()
                                        .contains(controller.search.value
                                            .toLowerCase()))
                                    .map((data) => Dismissible(
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (direction) async {
                                            controller.deleteUser(data.id);
                                          },
                                          key: UniqueKey(),
                                          background: Container(
                                            color: Colors.red,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            child: const Align(
                                              alignment: Alignment.centerRight,
                                              child: Icon(
                                                FontAwesomeIcons.trashAlt,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 8, right: 8, top: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey)),
                                            child: ListTile(
                                              isThreeLine: true,
                                              horizontalTitleGap: 0,
                                              contentPadding: EdgeInsets.zero,
                                              leading: Material(
                                                clipBehavior: Clip.hardEdge,
                                                shape: const CircleBorder(),
                                                child: Ink.image(
                                                  fit: BoxFit.cover,
                                                  width: 72,
                                                  height: 72,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          data.image),
                                                ),
                                              ),
                                              title: Text(data.name),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.age,
                                                    style: const TextStyle(
                                                        letterSpacing: 1.1),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data.horoscope,
                                                    style: const TextStyle(
                                                        letterSpacing: 1.3),
                                                  ),
                                                ],
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    splashRadius: 25,
                                                    icon: const Icon(
                                                        FontAwesomeIcons
                                                            .pencilAlt,
                                                        size: 20),
                                                    onPressed: () => Get.dialog(
                                                        CustomCreateUserModal(
                                                      isUpdate: true,
                                                      userModel: data,
                                                    )),
                                                  ),
                                                  IconButton(
                                                    splashRadius: 25,
                                                    icon: const Icon(
                                                        FontAwesomeIcons
                                                            .trashAlt,
                                                        size: 20),
                                                    onPressed: () => controller
                                                        .deleteUser(data.id),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(controller.isConnect.value
                            ? "No Data !"
                            : "No Connection !")),
          )),
    );
  }
}
