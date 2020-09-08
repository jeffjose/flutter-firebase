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
            streamStates: [store.emailx],
            builder: (_) => Text(store.emailx.state.toString()),
          ),
          Text('Public List', style: TextStyle(fontSize: 16))
        ]),
      ),
      StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder: (context, stream) {
            if (stream.connectionState == ConnectionState.waiting) {
              return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            }

            if (stream.hasError) {
              return Center(child: Text(stream.error.toString()));
            }

            QuerySnapshot querySnapshot = stream.data;

            return SliverPadding(
                padding: EdgeInsets.all(20.0),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Container(
                    child: Text(querySnapshot.docs[index].data()['name']),
                  );
                }, childCount: querySnapshot.size)));
          })
    ]));
  }
}
