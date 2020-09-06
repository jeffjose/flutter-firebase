import 'package:flutter/material.dart';
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
        title: GetX<AuthController>(
            init: Get.put<AuthController>(AuthController()),
            builder: (_) {
              if (_.user != null) {
                return Text("User: " + controller.user.email);
              } else {
                return Text("User none");
              }
            }),
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
          Text('Foo'),
          Text('Public List', style: TextStyle(fontSize: 16))
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
          })
    ]));
  }
}
