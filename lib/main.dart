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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton(
            onPressed: null,
            backgroundColor: kMKRColorMain,
            child: const Icon(Icons.play_arrow_rounded),
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Image(
              image: AssetImage('images/MKR-logo-small-blue.png'),
            ),
          ),
        ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: ListView(
            children: [
              const DrawerHeader(
                child: Image(
                  image: AssetImage('images/MKR-logo-long-blue.png'),
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.headphones,
                  color: kMKRColorMain,
                ),
                title: const Text('Listen Now!'),
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Content Hangat!'),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.globeAsia,
                  color: kMKRColorMain,
                ),
                title: const Text('Laman Web'),
              ),
              ListTile(
                leading: Icon(
                  Icons.mic,
                  color: kMKRColorMain,
                ),
                title: const Text('Show Clip'),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.youtube,
                  color: kMKRColorMain,
                ),
                title: const Text('MyKampus TV'),
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Social Media'),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: kMKRColorMain,
                ),
                title: const Text('Facebook'),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.twitter,
                  color: kMKRColorMain,
                ),
                title: const Text('Twitter'),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.instagramSquare,
                  color: kMKRColorMain,
                ),
                title: const Text('Instagram'),
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Hubungi Kami'),
              ),
              ListTile(
                leading: Icon(
                  Icons.call,
                  color: kMKRColorMain,
                ),
                title: const Text('Telephone'),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.whatsappSquare,
                  color: kMKRColorMain,
                ),
                title: const Text('WhatsApp'),
              ),
              ListTile(
                leading: Icon(
                  Icons.place,
                  color: kMKRColorMain,
                ),
                title: const Text('Lokasi'),
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Text('Extra'),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: kMKRColorMain,
                ),
                title: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
