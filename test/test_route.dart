// // ! Taken from https://stackoverflow.com/questions/67838448/flutter-navigator-2-0-named-routes-with-drawer-navigation

// import 'dart:async';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//   final _mainNavigatorKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Navigator Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // home: const NavigatorPage(title: 'Flutter Demo Home Page'),
//       navigatorKey: _mainNavigatorKey,
//       routes: {
//         /// [title] updates the title on the main AppBar
//         /// [route] NavigatorPage Router depends on route defined on this parameter
//         /// [showDrawer] show/hide main AppBar drawer
//         Nemo.home: (context) => NavigatorPage(
//               title: 'Home',
//               route: Nemo.home,
//               navigatorKey: _mainNavigatorKey,
//               showDrawer: true,
//             ),
//         Nemo.post: (context) => NavigatorPage(
//             title: 'Post',
//             route: Nemo.post,
//             navigatorKey: _mainNavigatorKey,
//             showDrawer: true),
//         Nemo.profile: (context) => NavigatorPage(
//             title: 'Profile',
//             route: Nemo.profile,
//             navigatorKey: _mainNavigatorKey,
//             showDrawer: true),
//         Nemo.settings: (context) => NavigatorPage(
//             title: 'Settings',
//             route: Nemo.settings,
//             navigatorKey: _mainNavigatorKey,
//             showDrawer: true),
//       },
//     );
//   }
// }

// class NavigatorPage extends StatefulWidget {
//   const NavigatorPage(
//       {Key? key,
//       required this.title,
//       required this.route,
//       required this.navigatorKey,
//       required this.showDrawer})
//       : super(key: key);

//   final String title;
//   final String route;
//   final bool showDrawer;
//   final GlobalKey<NavigatorState> navigatorKey;

//   @override
//   State<NavigatorPage> createState() => _NavigatorPageState();
// }

// class _NavigatorPageState extends State<NavigatorPage> {
//   // final _navigatorKey = GlobalKey<NavigatorState>();
//   /// Drawer delay let's us have the Navigation Drawer close first
//   /// before the navigating to the next Screen
//   int drawerDelay = 300;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       drawer: widget.showDrawer
//           ? Drawer(
//               /// TODO return null to hide Drawer if in Login/Registration page
//               // Add a ListView to the drawer. This ensures the user can scroll
//               // through the options in the drawer if there isn't enough vertical
//               // space to fit everything.
//               child: ListView(
//                 // Important: Remove any padding from the ListView.
//                 padding: EdgeInsets.zero,
//                 children: <Widget>[
//                   const DrawerHeader(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                     ),
//                     child: Text('Drawer Header'),
//                   ),
//                   ListTile(
//                     title: const Text('Home'),
//                     onTap: () {
//                       // Close the drawer
//                       Navigator.pop(context);

//                       /// [drawerDelay] gives time to animate the closing of the Drawer
//                       Timer(Duration(milliseconds: drawerDelay), () async {
//                         widget.navigatorKey.currentState!.pushNamed(Nemo.home);
//                       });
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('Profile'),
//                     onTap: () {
//                       // Close the drawer
//                       Navigator.pop(context);

//                       Timer(Duration(milliseconds: drawerDelay), () async {
//                         widget.navigatorKey.currentState!
//                             .pushNamed(Nemo.profile);
//                       });
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('Settings'),
//                     onTap: () {
//                       // Close the drawer
//                       Navigator.pop(context);

//                       Timer(Duration(milliseconds: drawerDelay), () async {
//                         widget.navigatorKey.currentState!
//                             .pushNamed(Nemo.settings);
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             )
//           : null,
//       body: Navigator(
//         // key: _navigatorKey,

//         /// initialRoute needs to be set to '/'
//         onGenerateRoute: (RouteSettings settings) {
//           WidgetBuilder builder;
//           // Manage your route names here
//           // switch (settings.name) {
//           switch (widget.route) {

//             /// Default page displayed on Home Screen
//             case Nemo.home:
//               builder = (BuildContext context) => _homePage();
//               break;
//             case Nemo.post:
//               builder = (BuildContext context) => _postPage();
//               break;
//             case Nemo.profile:
//               builder = (BuildContext context) => _profilePage();
//               break;
//             case Nemo.settings:
//               builder = (BuildContext context) => _settingsPage();
//               break;
//             default:
//               builder = (BuildContext context) => const UnknownPage();
//           }
//           return MaterialPageRoute(
//             builder: builder,
//             settings: settings,
//           );
//         },
//       ),
//     );
//   }

//   Widget _homePage() =>
//       HomePage(title: 'Home', navigatorKey: widget.navigatorKey);
//   Widget _postPage() =>
//       PostPage(title: 'Post', navigatorKey: widget.navigatorKey);
//   Widget _profilePage() =>
//       ProfilePage(title: 'Profile', navigatorKey: widget.navigatorKey);
//   Widget _settingsPage() =>
//       SettingsPage(title: 'Settings', navigatorKey: widget.navigatorKey);
// }

// class Nemo {
//   static const home = '/';
//   static const login = '/login';
//   static const register = '/register';
//   static const post = '/post';
//   static const profile = '/profile';
//   static const settings = '/settings';
// }

// /// Constant values for UI elements
// class Constants {
//   static const String webVersion = 'web-0.1.9-dev';
//   static const double paddingSmall = 8.0;
//   static const double paddingNormal = 16.0;

//   static const double heightNormal = 64.0;

//   static const double heightThreadCard = 72.0;
//   static const double heightButtonNormal = 42.0;

//   static const double widthButtonNormal = 160.0;
// }

// class UnknownPage extends StatefulWidget {
//   const UnknownPage({Key? key}) : super(key: key);

//   @override
//   State<UnknownPage> createState() => _UnknownPageState();
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key, required this.title, required this.navigatorKey})
//       : super(key: key);
//   final String title;
//   final GlobalKey<NavigatorState> navigatorKey;

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Home',
//             ),
//             ElevatedButton(
//               child: const Text('View Post Page'),
//               onPressed: () {
//                 widget.navigatorKey.currentState!.pushNamed(Nemo.post);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PostPage extends StatefulWidget {
//   const PostPage(
//       {Key? key, required this.title, this.id, required this.navigatorKey})
//       : super(key: key);

//   final String title;
//   final String? id;
//   final GlobalKey<NavigatorState> navigatorKey;

//   @override
//   State<PostPage> createState() => _PostPageState();
// }

// class _PostPageState extends State<PostPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Id from Route: ${widget.id}',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SettingsPage extends StatefulWidget {
//   const SettingsPage(
//       {Key? key, required this.title, required this.navigatorKey})
//       : super(key: key);
//   final String title;
//   final GlobalKey<NavigatorState> navigatorKey;

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Settings',
//             ),
//             ElevatedButton(
//               child: const Text('View Details'),
//               onPressed: () {
//                 widget.navigatorKey.currentState!.pushNamed(Nemo.post);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key, required this.title, required this.navigatorKey})
//       : super(key: key);
//   final String title;
//   final GlobalKey<NavigatorState> navigatorKey;

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Profile',
//             ),
//             ElevatedButton(
//               child: const Text('View Details'),
//               onPressed: () {
//                 widget.navigatorKey.currentState!.pushNamed(Nemo.post);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _UnknownPageState extends State<UnknownPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text(
//               '404',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
