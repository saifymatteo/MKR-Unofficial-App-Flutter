import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kMKRColorMain,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyKampus Radio'),
        ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListView(
            children: const [
              DrawerHeader(
                child: Text('Drawer Header Text'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.headphones),
                title: Text('Listen Now!'),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Content Hangat!'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.globeAsia),
                title: Text('Laman Web'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.microphone),
                title: Text('Show Clip'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.youtube),
                title: Text('MyKampus TV'),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Social Media'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.facebook),
                title: Text('Facebook'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.twitter),
                title: Text('Twitter'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.instagramSquare),
                title: Text('Instagram'),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Hubungi Kami'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.phone),
                title: Text('Telephone'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.whatsappSquare),
                title: Text('WhatsApp'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.locationArrow),
                title: Text('Lokasi'),
              ),
              Divider(
                height: 20,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Extra'),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.toolbox),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
