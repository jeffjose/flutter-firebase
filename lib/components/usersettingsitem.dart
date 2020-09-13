import 'package:flutter/material.dart';

class UserSettingsItem extends StatelessWidget {
  final IconData icon;
  final String text;

  UserSettingsItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Icon(icon),
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
        ));
  }
}
