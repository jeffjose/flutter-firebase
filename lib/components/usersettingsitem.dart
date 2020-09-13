import 'package:flutter/material.dart';

class UserSettingsItem extends StatelessWidget {
  final IconData icon;
  final String text;

  UserSettingsItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Icon(icon),
              ),
              Text(text),
            ],
          ),
        ));
  }
}
