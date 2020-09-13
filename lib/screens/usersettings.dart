import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stream_state/stream_state.dart';
import 'package:stream_state/stream_state_builder.dart';
import '../stores/store.dart';
import '../firebase/firebase.dart';
import '../components/usersettingsitem.dart';
import '../components/usersettingsheader.dart';

class UserSettings extends StatefulWidget {
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
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
                child: StreamStateBuilder(
                    streamState: store.user,
                    builder: (_, _i) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 15),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  child: ClipOval(
                                    child: (store.user.state != null)
                                        ? Image.network(
                                            store.user.state.photoURL,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.account_circle,
                                            size: 80,
                                            color: Colors.green[300],
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: (store.user.state != null)
                                      ? Text(
                                          store.user.state.displayName,
                                        )
                                      : Text(
                                          'Anonymous',
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: RawMaterialButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    constraints: BoxConstraints(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                      side: BorderSide(
                                        color: (store.user.state != null)
                                            ? Colors.red[300]
                                            : Colors.green[300],
                                      ),
                                    ),
                                    onPressed: () {
                                      if (store.user.state != null) {
                                        signOut();
                                      } else {
                                        signInWithGoogle();
                                      }
                                    },
                                    child: (store.user.state != null)
                                        ? Text(
                                            'Logout',
                                            style: TextStyle(
                                              color: Colors.red[300],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Text(
                                            'Login',
                                            style: TextStyle(
                                              color: Colors.green[300],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
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
