import 'dart:io';

import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 150,
          ),
          SizedBox(height: 30),
          Text('Flutter Firebase',
              style: Theme.of(context).textTheme.headline5),
          SizedBox(height: 10),
          Text('Version: 1234', style: Theme.of(context).textTheme.bodyText1),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
