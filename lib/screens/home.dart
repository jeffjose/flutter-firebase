import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_firebase/firebase/firebase.dart';
import 'package:flutter_firebase/stores/store.dart';
import 'package:stream_state/stream_state_builder.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
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
    ]);
  }
}
