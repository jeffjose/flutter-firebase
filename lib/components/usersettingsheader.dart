import 'package:flutter/material.dart';

class UserSettingsHeader extends StatelessWidget {
  //final Icon icon;
  final String text;

  UserSettingsHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(fontWeight: FontWeight.bold),
        )
        //TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        );
  }
}
