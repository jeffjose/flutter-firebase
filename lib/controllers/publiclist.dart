import 'package:get/get.dart';

import 'package:flutter_firebase/models/publiclist.dart';
import 'package:flutter_firebase/services/database.dart';

class PublicListController extends GetxController {
  Rx<List<PublicListItem>> _publicList = Rx<List<PublicListItem>>();

  List<PublicListItem> get publiclist => _publicList.value;

  @override
  onInit() {
    print('--------------------');
    print('oninit');
    print('--------------------');

    _publicList.bindStream(Database().publicListStream());
  }
}
