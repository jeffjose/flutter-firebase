import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream_state/stream_state_builder.dart';

import 'firebase/firebase.dart';
import 'stores/store.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('publiclist');

    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            title: Text('Home'),
            backgroundColor: Color(0xff2E2E2E),
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
              MultiStreamStateBuilder(
                streamStates: [store.user, store.publicStore],
                builder: (_) => Column(
                  children: [
                    Text(
                        '${store.publicStore.state.length}, ${store.privilagedStore.state.length}'),
                    (store.user.state != null)
                        ? Text('${store.user.state.email}')
                        : Text(''),
                    (store.user.state != null)
                        ? Text('${store.user.state.displayName}')
                        : Text(''),
                    (store.user.state != null)
                        ? Text('${store.user.state.photoUrl}')
                        : Text(''),
                  ],
                ),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
                [Text('Privilaged List', style: TextStyle(fontSize: 16))]),
          ),
          MultiStreamStateBuilder(
              streamStates: [store.publicStore],
              builder: (_) {
                return SliverPadding(
                    padding: EdgeInsets.all(20.0),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        child: Text(store.publicStore.state[index].name),
                      );
                    }, childCount: store.publicStore.state.length)));
              }),
          SliverList(
            delegate: SliverChildListDelegate(
                [Text('Privilaged List', style: TextStyle(fontSize: 16))]),
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
          height: 60,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text('')),
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
                                  color: Color(0xFF2E2E2E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  //border: Border.all(color: Colors.red, width: 0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    border: Border.all(
                                        color: Color(0x00FF0000), width: 0),
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
            selectedItemColor: Colors.amber[800],
          ),
        ));
  }
}
