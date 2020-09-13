import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stream_state/stream_state.dart';
import 'package:flutter_firebase/stores/store.dart';

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
                              child: Image.network(
                                user.state.photoURL,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              user.state.displayName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                color: Theme.of(context).primaryColorDark,
                height: 180,
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Text('USER SETTINGS'),
              Container(color: Colors.red, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.yellow, height: 50),
              Container(color: Colors.red, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.blue, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.orange, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.amber, height: 50),
              Container(color: Colors.red, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.yellow, height: 50),
              Container(color: Colors.red, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.blue, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.orange, height: 50),
              Container(color: Colors.green, height: 50),
              Container(color: Colors.amber, height: 50),
            ]),
          ),
        ],
      ),
    );
  }
}
