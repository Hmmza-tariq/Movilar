import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/custom_app_bar.dart';
import 'package:movilar/app/modules/widgets/custom_elevated_button.dart';
import 'package:movilar/app/modules/widgets/loading.dart';
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
          physics: const NeverScrollableScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                CustomElevatedButton(
                    onPressed: () {
                      controller.connect();
                    },
                    text:
                        controller.isConnected.value ? "Connected" : "Connect"),
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
                          labelStyle: TextStyle(
                              fontSize: 16, color: ColorManager.white),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomElevatedButton(
                    onPressed: () {
                      if (controller.topicController.text.isEmpty) {
                        Get.snackbar(
                            "Error", "Please add topic to subscribe to",
                            colorText: ColorManager.white,
                            backgroundColor: ColorManager.red);
                        return;
                      }
                      controller.subscribe();
                    },
                    text: controller.isSubscribed.value
                        ? "Subscribed"
                        : "Subscribe"),
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
                          labelStyle: TextStyle(
                              fontSize: 16, color: ColorManager.white),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomElevatedButton(
                    onPressed: () {
                      if (controller.messageController.text.isEmpty ||
                          controller.topicController.text.isEmpty) {
                        Get.snackbar("Error", "Please fill all fields",
                            colorText: ColorManager.white,
                            backgroundColor: ColorManager.red);
                        return;
                      }
                      controller.publish();
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
                      SizedBox(
                        height: Get.height * 0.27,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: controller.message.length,
                            itemBuilder: (context, index) {
                              var message =
                                  controller.message[index].split(",")[0];
                              var topic =
                                  controller.message[index].split(",")[1];

                              return Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Message: ",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: ColorManager.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: message,
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: ColorManager.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const TextSpan(
                                      text: " - Topic: ",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: ColorManager.lightGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: topic,
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: ColorManager.lightGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
