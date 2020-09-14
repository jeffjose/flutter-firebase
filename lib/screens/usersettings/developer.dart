import 'package:flutter/material.dart';
import '../../components/usersettingsitem.dart';

class UserSettingsDeveloper extends StatefulWidget {
  @override
  _UserSettingsDeveloperState createState() => _UserSettingsDeveloperState();
}

class _UserSettingsDeveloperState extends State<UserSettingsDeveloper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            title: Text('Developer settings',
                style: Theme.of(context).textTheme.headline6)),
        SliverList(
          delegate: SliverChildListDelegate([
            UserSettingsItem(Icons.code, 'Setting 1', Container()),
            UserSettingsItem(Icons.code, 'Setting 1', Container()),
            UserSettingsItem(Icons.code, 'Setting 1', Container()),
            UserSettingsItem(Icons.code, 'Setting 1', Container()),
            UserSettingsItem(Icons.code, 'Setting 1', Container()),
          ]),
        )
      ]),
    );
  }
}
