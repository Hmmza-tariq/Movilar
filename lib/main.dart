import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';
import 'package:movilar/app/resources/theme_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movilar/app/services/internet_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBluePlus.setLogLevel(LogLevel.info, color: false);
  await dotenv.load(fileName: ".env");
  await Get.put(InternetService()).checkInternet();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      GetMaterialApp(
        title: "Movilar",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    };
  });
}
