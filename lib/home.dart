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
        leading: Icon(Icons.menu),
        backgroundColor: Colors.black54,
        pinned: true,
        //actions: <Widget>[
        //  GoogleUserCircleAvatar(
        //    identity: _currentUser,
        //  )
        //]
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
            streamStates: [store.email, store.publicStore],
            builder: (_) => Column(
              children: [
                Text('${store.publicStore.state.length}'),
                Text('${store.email.state}'),
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
    ]));
  }
}
