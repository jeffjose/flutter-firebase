import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase/firebase.dart';
import '../stores/store.dart';
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
          SizedBox(height: 30),
          Text('Public List', style: Theme.of(context).textTheme.headline6),
          RaisedButton(
              child: Text('Add item'),
              onPressed: () {
                addItemToCollection('publiclist');
              }),
          RaisedButton(
              child: Text('Remove item'),
              onPressed: () {
                removeItemFromCollection('publiclist');
              }),
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
        delegate: SliverChildListDelegate(
          [
            Text('Privilaged List',
                style: Theme.of(context).textTheme.headline6),
            RaisedButton(
                child: Text('Add item'),
                onPressed: () {
                  addItemToCollection('privilagedlist');
                }),
            RaisedButton(
                child: Text('Remove item'),
                onPressed: () {
                  removeItemFromCollection('privilagedlist');
                }),
          ],
        ),
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
