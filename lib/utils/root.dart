import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './../controllers/auth.dart';

class Root GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      initState: (_) async {
        Get.put<UserController>(UserContrller());
      },
      builder: (_) {
        return Home()
      },

    )
  }

}
