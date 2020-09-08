import 'package:flutter_firebase/controllers/auth.dart';
import 'package:get/get.dart';

import 'package:flutter_firebase/models/privilagedlist.dart';
import 'package:flutter_firebase/services/database.dart';

class PrivilagedListController extends GetxController {
  Rx<List<PrivilagedListItem>> _privilagedList = Rx<List<PrivilagedListItem>>();

  List<PrivilagedListItem> get privilagedlist => _privilagedList.value;

  @override
  onInit() {
    String uid = Get.find<AuthController>().user?.uid;
    print('PRIVILAGED LIST CONTROLLER for ${uid}');

    _privilagedList.bindStream(Database().privilagedListStream(uid));
  }
}
