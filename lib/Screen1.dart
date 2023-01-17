import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_556/Wallpaperhub.dart';
import 'package:flutter_556/YoutubeScreen.dart';
import 'package:flutter_556/screens/email_auth/loginscreen.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => loginscreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text("My Home page"),
      ),body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Wallpaperhub(),) );
              
            }, child: Text("Wallpaper Hub")),

            SizedBox(
              height: 70,
            ),

            ElevatedButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => Youtube(),) );
              
            }, child: Text("Youtube links")),
          ],
        ),
      ),
    );
  }
}
