import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mkr_flutter/utils/constant.dart';

class DrawerNav extends StatelessWidget {
  const DrawerNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () => Navigator.pop(context),
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
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(
              Icons.mic,
              color: kMKRColorMain,
            ),
            title: const Text('Show Clip'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.youtube,
              color: kMKRColorMain,
            ),
            title: const Text('MyKampus TV'),
            onTap: () => Navigator.pop(context),
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
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.twitter,
              color: kMKRColorMain,
            ),
            title: const Text('Twitter'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.instagramSquare,
              color: kMKRColorMain,
            ),
            title: const Text('Instagram'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.tiktok,
              color: kMKRColorMain,
            ),
            title: const Text('TikTok'),
            onTap: () => Navigator.pop(context),
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
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.whatsappSquare,
              color: kMKRColorMain,
            ),
            title: const Text('WhatsApp'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(
              Icons.place,
              color: kMKRColorMain,
            ),
            title: const Text('Lokasi'),
            onTap: () => Navigator.pop(context),
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
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
