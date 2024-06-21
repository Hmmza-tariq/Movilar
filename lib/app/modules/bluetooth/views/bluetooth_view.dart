import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movilar/app/modules/widgets/custom_app_bar.dart';
import 'package:movilar/app/modules/widgets/custom_elevated_button.dart';
import 'package:movilar/app/resources/color_manager.dart';

import '../controllers/bluetooth_controller.dart';

class BluetoothView extends StatelessWidget {
  const BluetoothView({super.key});
  @override
  Widget build(BuildContext context) {
    BluetoothController controller = Get.put(BluetoothController());
    return Scaffold(
        appBar: customAppBar("Bluetooth"),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Status:",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white)),
              ),
              Obx(() => controller.isConnected.value
                  ? CustomElevatedButton(
                      onPressed: () {
                        controller.turnOFF();
                      },
                      text: "Connected",
                      bgColor: ColorManager.green,
                      fgColor: ColorManager.white,
                    )
                  : CustomElevatedButton(
                      onPressed: () {
                        controller.turnON();
                      },
                      text: "Disconnected",
                      bgColor: ColorManager.red,
                      fgColor: ColorManager.white,
                    )),
              const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20, top: 50),
                child: Text("Paired Devices",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.white)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: ColorManager.white,
                  thickness: 1,
                ),
              ),
              Obx(() => SizedBox(
                    height: Get.height * 0.5,
                    child: controller.isConnected.value == false
                        ? const Center(
                            child: Text("Bluetooth is off",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.white)),
                          )
                        : FutureBuilder(
                            future: controller.getConnectedDevices(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorManager.white,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ListView.builder(
                                    itemCount:
                                        controller.connectedDevices.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(
                                          controller.connectedDevices[index]
                                              .platformName,
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: ColorManager.white),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                  ))
            ],
          ),
        ));
  }
}
