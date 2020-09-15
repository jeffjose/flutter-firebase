import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/SharedAxisPageRoute.dart';

class UserSettingsItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget page;
  final SharedAxisTransitionType transitionType;

  UserSettingsItem(this.icon, this.text, this.page, this.transitionType);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          //MaterialPageRoute(builder: (context) => route),
          SharedAxisPageRoute(page: page, transitionType: transitionType),
        );
      },
      child: Container(
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
          )),
    );
  }
}
