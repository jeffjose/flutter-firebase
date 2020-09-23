import 'package:flutter/material.dart';
import '../notifications/index.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firebase/index.dart';
import '../stores/index.dart';
import 'package:stream_state/stream_state_builder.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.invert_colors),
              tooltip: "tooltip search",
              onPressed: () {
                store.darkMode.state = !store.darkMode.state;
              },
            ),
          ],
          title: Text('Home',
              style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.headline6))
          //style: GoogleFonts.inter(color: appTheme.appBarColor)),
          //backgroundColor: appTheme.appBarBackgroundColor,
          ),
      SliverList(
        delegate: SliverChildListDelegate([
          SizedBox(height: 30),
          Row(
            children: [
              RaisedButton(
                  child: Text('now'),
                  onPressed: () {
                    print('Showing notification now');
                    showNotification('Hello World!', 'A message for you.');
                  }),
              RaisedButton(
                  child: Text('in 1min'),
                  onPressed: () {
                    DateTime _dt = DateTime.now();
                    DateTime dt = _dt.add(Duration(minutes: 1));

                    print('Scheduling for $dt');
                    scheduleNotification(
                      "myid",
                      "title",
                      "Scheduled for ${dt.toString()}",
                      dt,
                    );
                  }),
              RaisedButton(
                  child: Text('every 1min'),
                  onPressed: () {
                    var interval = RepeatInterval.EveryMinute;
                    DateTime _dt = DateTime.now();
                    print('Scheduling for every min. Timenow: $_dt');
                    scheduleNotificationPeriodically(
                      "myid",
                      "title",
                      "Scheduled for every min",
                      interval,
                    );
                  }),
              RaisedButton(
                  child: Text('Cancel All'),
                  onPressed: () {
                    print('Cancelling all');
                    turnOffAllNotifications();
                  }),
            ],
          ),
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
