import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/custom_app_bar.dart';
import 'package:movilar/app/modules/widgets/custom_elevated_button.dart';
import 'package:movilar/app/resources/color_manager.dart';

import '../controllers/mqtt_controller.dart';

class MqttView extends StatelessWidget {
  const MqttView({super.key});
  @override
  Widget build(BuildContext context) {
    MqttController controller = Get.put(MqttController());
    return Scaffold(
      appBar: customAppBar("MQTT"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.1,
              width: Get.width * 0.96,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    controller: controller.topicController,
                    maxLines: 1,
                    cursorColor: ColorManager.blue,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: ColorManager.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.transparent,
                        ),
                      ),
                      labelText: 'Topic',
                      hintText: 'Type Topic Here',
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.transparent,
                        ),
                      ),
                      hintStyle: TextStyle(
                          fontSize: 16, color: ColorManager.lightGrey),
                      labelStyle:
                          TextStyle(fontSize: 16, color: ColorManager.white),
                    ),
                  ),
                ),
              ),
            ),
            CustomElevatedButton(
                onPressed: () {
                  controller.connect();
                },
                text: "Connect"),
            CustomElevatedButton(
                onPressed: () {
                  controller.subscribe(controller.topicController.text);
                },
                text: "Subscribe"),
            SizedBox(
              height: Get.height * 0.1,
              width: Get.width * 0.96,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    controller: controller.messageController,
                    maxLines: 1,
                    cursorColor: ColorManager.blue,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: ColorManager.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.transparent,
                        ),
                      ),
                      labelText: 'Message',
                      hintText: 'Type Message Here',
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.transparent,
                        ),
                      ),
                      hintStyle: TextStyle(
                          fontSize: 16, color: ColorManager.lightGrey),
                      labelStyle:
                          TextStyle(fontSize: 16, color: ColorManager.white),
                    ),
                  ),
                ),
              ),
            ),
            CustomElevatedButton(
                onPressed: () {
                  controller.publishMessage(controller.topicController.text,
                      controller.messageController.text);
                },
                text: "Publish"),
            SizedBox(
              width: Get.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  const Text(
                    "Published Message:",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: ColorManager.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Obx(() => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(controller.message.value,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: ColorManager.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
