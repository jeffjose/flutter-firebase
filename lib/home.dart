import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_state/stream_state_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_firebase/firebase/firebase.dart';
import 'package:flutter_firebase/stores/store.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('publiclist');

    AppTheme appTheme = store.theme.state;
    store.darkMode.stream.listen((event) {
      appTheme = store.theme.state;
    });

    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
              title: Text('Home',
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.headline6))
              //style: GoogleFonts.inter(color: appTheme.appBarColor)),
              //backgroundColor: appTheme.appBarBackgroundColor,
              ),
          SliverList(
            delegate: SliverChildListDelegate([
              RaisedButton(
                  child: Text('Login'),
                  onPressed: () {
                    signInWithGoogle();
                  }),
              RaisedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    signOut();
                  }),
              RaisedButton(
                  child: Text('Switch theme'),
                  onPressed: () {
                    store.darkMode.state = !store.darkMode.state;
                  }),
              Text('Privilaged List', style: TextStyle(fontSize: 16))
            ]),
          ),
          MultiStreamStateBuilder(
              streamStates: [store.publicStore],
              builder: (_) {
                return SliverPadding(
                    padding: EdgeInsets.all(20.0),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        child: Text(
                          store.publicStore.state[index].name,
                        ),
                      );
                    }, childCount: store.publicStore.state.length)));
              }),
          SliverList(
            delegate: SliverChildListDelegate([
              Text('Privilaged List',
                  style: TextStyle(
                    fontSize: 16,
                  ))
            ]),
          ),
          MultiStreamStateBuilder(
              streamStates: [store.privilagedStore],
              builder: (_) {
                return SliverPadding(
                    padding: EdgeInsets.all(20.0),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        child: Text(store.privilagedStore.state[index].name),
                      );
                    }, childCount: store.privilagedStore.state.length)));
              }),
        ]),
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            onTap: (index) {
              print(index);
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Colors.grey[400],
                  ),
                  title: Text('')),
              BottomNavigationBarItem(
                  icon: InkResponse(
                    child: StreamStateBuilder(
                        streamState: store.user,
                        builder: (_, _i) {
                          if (store.user.state != null) {
                            return CircleAvatar(
                              radius: 15,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color:
                                      store.theme.state.appBarBackgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  //border: Border.all(color: Colors.red, width: 0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                        color: Color(0x00ffffff), width: 0),
                                    image: DecorationImage(
                                        image: Image.network(
                                                store.user.state.photoURL)
                                            .image,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Icon(Icons.account_circle);
                          }
                        }),
                  ),
                  title: Text('')),
            ],
            selectedItemColor: Theme.of(context).accentColor,
          ),
        ));
  }
}
