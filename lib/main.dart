import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stream_state/stream_state.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import './screens/home.dart';
import './screens/usersettings.dart';
import './screens/chat.dart';

import './stores/store.dart';
import './firebase/firebase.dart';
import './themes/theme.dart';

import 'package:stream_state/stream_state_builder.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>['email']);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStreamStatePersist();
  //await Firebase.initializeApp();
  final Future<FirebaseApp> _app = Firebase.initializeApp();

  Stream.fromFuture(_app).listen((app) {
    authListener();
    collectionListener();

    // Required for statusbar and navbar theme switch.
    // The full app theme is piped through `themeMode`
    themeListener();
  });

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
        store.theme.state.appBarBackgroundColor);
    FlutterStatusbarcolor.setNavigationBarColor(
        store.theme.state.appBarBackgroundColor);

    return withMaterialApp(Center(child: Main()), context);
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;

  List<Widget> screens = [Home(), Chat(), UserSettings()];

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = store.theme.state;
    store.darkMode.stream.listen((event) {
      appTheme = store.theme.state;
    });

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
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
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
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          ),
        ));
  }
}
