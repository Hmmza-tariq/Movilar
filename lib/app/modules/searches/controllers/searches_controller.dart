import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movilar/app/data/movie.dart';
import 'package:movilar/app/modules/home/controllers/home_controller.dart';

class SearchesController extends GetxController {
  var searchResult = <Movie>[].obs;
  TextEditingController searchController = TextEditingController();
  HomeController homeController = Get.find();
  @override
  void onInit() {
    searchController.addListener(() {
      search(searchController.text);
    });
    super.onInit();
  }

  void search(String query) {
    searchResult.value = homeController.searchMovie(query);
    update();
  }
}
