import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/privilagedlist.dart';
import 'package:flutter_firebase/models/publiclist.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'package:flutter_firebase/controllers/auth.dart';
import 'package:flutter_firebase/controllers/publiclist.dart';
import 'package:flutter_firebase/services/database.dart';

class Home extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        title: Obx(
          () =>
              Text((controller.user != null) ? controller.user.email : 'none'),
        ),
        backgroundColor: Colors.black54,
        pinned: true,
        //actions: <Widget>[
        //  GoogleUserCircleAvatar(
        //    identity: _currentUser,
        //  )
        //]
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          RaisedButton(
              child: Text('Log in'),
              onPressed: () {
                controller.login();
              }),
          RaisedButton(
              child: Text('Log out'),
              onPressed: () {
                controller.logout();
              }),
        ]),
      ),
      SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Public List', style: TextStyle(fontSize: 20)),
          ),
        ]),
      ),
      GetX<PublicListController>(
          init: Get.put<PublicListController>(PublicListController()),
          builder: (_) {
            if (_ == null || _.publiclist == null) {
              return SliverFillRemaining(
                  child: Center(
                child: Text('error'),
              ));
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  child: Text(_.publiclist[index].name),
                );
              }, childCount: _.publiclist.length),
            );
          }),
      SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Privilaged List', style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Text(
                (controller.user != null) ? controller.user.uid : '',
                style: TextStyle(fontSize: 15))),
          ),
        ]),
      ),
      GetX<PrivilagedListController>(
          init: Get.put<PrivilagedListController>(PrivilagedListController()),
          builder: (_) {
            print('xxx');
            print(_);
            print(_.privilagedlist);
            if (_ == null || _.privilagedlist == null) {
              return SliverFillRemaining(
                child: Text(''),
              );
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  child: Text(_.privilagedlist[index].name),
                );
              }, childCount: _.privilagedlist.length),
            );
          })
    ]));
  }
}
