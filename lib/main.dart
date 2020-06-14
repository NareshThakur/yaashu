import 'package:flutter/material.dart';
import 'package:refnotes/pages/home.dart';
// import 'package:refnotes/pages/add_contact.dart';
import 'package:refnotes/pages/login.dart';
import 'package:refnotes/globals.dart' as globals;
import 'dart:async';
// import 'package:refnotes/widgets/text-widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:refnotes/pages/register.dart';


Map<int, Color> primaryColor =
{
  50:globals.primaryColor
};
MaterialColor primaryColorCustom = MaterialColor(0xFF880E4F,primaryColor);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: globals.primaryColor
        ),
        accentColor: globals.primaryColor,
        primaryColor: globals.primaryColor,
        buttonTheme: ButtonThemeData(
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.blueAccent),
          ),
          colorScheme: ColorScheme(
            primary: globals.primaryColor, 
            primaryVariant: globals.primaryColor, 
            secondary: globals.primaryColor, 
            secondaryVariant: globals.primaryColor, 
            surface: globals.primaryColor, 
            background: globals.primaryColor, 
            error: globals.primaryColor, 
            onPrimary: globals.primaryColor, 
            onSecondary: globals.primaryColor, 
            onSurface: globals.primaryColor, 
            onBackground: globals.primaryColor, 
            onError: globals.primaryColor, 
            brightness: Brightness.light
          ),

          buttonColor: globals.primaryColor,
          padding: const EdgeInsets.symmetric( vertical: 15, horizontal: 15 ),
        ),
        buttonColor: globals.primaryColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  // _SplashScreenState
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    setTimer();
  }

  authUser(){
    // Auth user
    
    FirebaseAuth.instance
    .currentUser()
    .then((currentUser){

      if( currentUser == null ){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        Firestore.instance
        .collection("users")
        .document(currentUser.uid)
        .get()
        .then((DocumentSnapshot result){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage( currentUser: currentUser.uid ),
            ),
          );
        })
        .catchError((error){
          print(error);
        });
        
      }

    });

  }


  setTimer() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, authUser);
  }

  check() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // colors: [ globals.primaryColor, globals.secondaryColor ])
            colors: [ Colors.grey, Colors.white60 ])
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset('images/logo.svg', height: 150,),
                // SizedBox(height: 10),
                // B( text: 'Yaashu', fontSize: 30 ),
                // P( text: "Project Tag Line", fontSize: 23 )
              ],
            ),
          ),
        )
        // child: Stack(
        //   alignment: Alignment.center,
        //   children: <Widget>[Image.asset('images/logo.png')],
        // ),
      ),
    );
  }
}