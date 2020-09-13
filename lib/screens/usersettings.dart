import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stream_state/stream_state.dart';
import 'package:flutter_firebase/stores/store.dart';

import 'package:flutter_firebase/components/usersettingsitem.dart';
import 'package:flutter_firebase/components/usersettingsheader.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    StreamState user = store.user;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              pinned: true,
              title: Text('User Settings',
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.headline6))),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            child: ClipOval(
                              child: (user.state != null)
                                  ? Image.network(
                                      user.state.photoURL,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: (user.state != null)
                                ? Text(
                                    user.state.displayName,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  )
                                : Text('Anonymous'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: (user.state != null)
                                ? Text('Logout')
                                : Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                color: Theme.of(context).primaryColorDark,
                height: 170,
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              UserSettingsHeader('APPEARENCE'),
              UserSettingsItem(Icons.palette, 'Dark Mode'),
              UserSettingsHeader('APP SETTINGS'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
              UserSettingsItem(Icons.brush, 'Dark Mode'),
            ]),
          ),
        ],
      ),
    );
  }
}
