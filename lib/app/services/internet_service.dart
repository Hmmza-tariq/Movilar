import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetService extends GetxService {
  var internetConnected = false.obs;

  Future<void> listenInternet() async {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        internetConnected.value = false;
      } else {
        internetConnected.value = true;
      }
    });
  }

  Future<void> checkInternet() async {
    await Connectivity().checkConnectivity().then((result) {
      if (result.contains(ConnectivityResult.none)) {
        internetConnected.value = false;
      } else {
        internetConnected.value = true;
      }
    });
    return;
  }
}
