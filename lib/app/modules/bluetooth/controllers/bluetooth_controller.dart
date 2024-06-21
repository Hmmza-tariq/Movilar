import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  var isConnected = false.obs;
  var connectedDevices = <BluetoothDevice>[].obs;

  @override
  void onInit() {
    super.onInit();
    requestBluetoothPermission();
    checkBluetoothState();
  }

  Future<void> requestBluetoothPermission() async {
    var status = await Permission.bluetooth.request();
    if (status.isGranted) {
      debugPrint("Bluetooth permission granted");
    } else {
      debugPrint("Bluetooth permission denied");
      // Get.snackbar(
      //   "Bluetooth permission",
      //   "Bluetooth permission is required to use this feature",
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  void checkBluetoothState() async {
    isConnected.value =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    FlutterBluePlus.adapterState.listen((state) async {
      isConnected.value = state == BluetoothAdapterState.on;
    });
  }

  Future<List<BluetoothDevice>> getConnectedDevices() {
    var devices = FlutterBluePlus.bondedDevices.then((value) {
      connectedDevices.addAll(value);
      return value;
    });

    return devices;
  }

  void turnON() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }

  void turnOFF() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOff();
    }
  }
}
