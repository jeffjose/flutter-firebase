import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stream_state/stream_state.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import './screens/home.dart';
import './screens/chat.dart';
import './screens/theme.dart';
import './screens/usersettings.dart';

import 'stores/index.dart';
import 'firebase/index.dart';
import 'themes/index.dart';

import 'notifications/index.dart';

import 'package:stream_state/stream_state_builder.dart';

NotificationAppLaunchDetails notificationAppLaunchDetails;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStreamStatePersist();
  //await Firebase.initializeApp();
  final Future<FirebaseApp> _app = Firebase.initializeApp();

  await signIn();

  Stream.fromFuture(_app).listen((app) {
    authListener();
    collectionListener();
    messagingListener();

    // Was originally for statusbar and navbar theme switch
    // but now they are set to transparent. This is still used
    // by navbar "focus" circle around avatar
    // The full app theme is piped through `themeMode`
    themeListener();
  });

  await initNotifications();

  await _app;

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  MaterialApp withMaterialApp(Widget body, BuildContext context) {
    ThemeData lightModeTheme = getLightModeTheme(context);
    ThemeData darkModeTheme = getDarkModeTheme(context);

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) {
          return Scaffold(body: body);
        },
        '/usersettings': (context) => UserSettings(),
      },
      title: 'Flutter Firebase',
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
      themeMode: store.darkMode.state ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    super.initState();

    // Setup a listener to update UI on theme switch
    store.darkMode.stream.listen((event) {
      // Force update
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        //store.theme.state.appBarBackgroundColor,
        Colors.transparent,
        animate: false);
    FlutterStatusbarcolor.setNavigationBarColor(
        //store.theme.state.appBarBackgroundColor,
        Colors.transparent,
        animate: false);

    return withMaterialApp(Center(child: Main()), context);
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;

  List<Widget> screens = [Home(), Chat(), ThemePage(), UserSettings()];

  @override
  Widget build(BuildContext context) {
    //AppTheme appTheme = store.theme.state;
    //store.darkMode.stream.listen((event) {
    //  appTheme = store.theme.state;
    //});

    return Scaffold(
        body: screens[index],
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (_i) => setState(() => index = _i),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                  ),
                  label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.palette), label: ''),
              BottomNavigationBarItem(
                  icon: InkResponse(
                    child: StreamStateBuilder(
                        streamState: store.user,
                        builder: (_, _i) {
                          if (store.user.state != null) {
                            return CircleAvatar(
                              radius: 17,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color:
                                      store.theme.state.appBarBackgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(17)),
                                  border: (index == 3)
                                      ? Border.all(
                                          color: Theme.of(context).accentColor,
                                          width: 2)
                                      : Border.all(
                                          color: Colors.transparent, width: 2),
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
                  label: ''),
            ],
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          ),
        ));
  }
}
