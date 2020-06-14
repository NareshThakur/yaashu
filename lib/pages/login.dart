import 'package:flutter/material.dart';
import 'package:refnotes/globals.dart' as globals;
import 'package:refnotes/pages/home.dart';
import 'package:refnotes/pages/register.dart';
import 'package:refnotes/widgets/text-widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  showInSnackBar(message){

    _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));

  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();

    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset('images/logo.svg', height: 100,),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: globals.textStyle,
                      controller: usernameController,
                      
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value.length == 0 ) return 'Invalid';
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: ("Username"),
                        labelStyle: globals.textStyle
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: globals.textStyle,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      validator: (value){
                        if(value.length == 0 ) return 'Invalid';
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        focusColor: Colors.grey[300],
                        fillColor: Colors.grey[300],
                        contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelText: ("Password"),
                        labelStyle: globals.textStyle
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      child: B(text: 'Login', color: Colors.white),
                      color: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric( vertical: 15 ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.blueAccent)
                      ),
                      onPressed: (){
                        showInSnackBar('Please wait...');
                        FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: usernameController.text, 
                          password: passwordController.text
                        )
                        .then((currentUser){
                          
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => HomePage( currentUser: currentUser.user.uid, ) )
                          );
                        })
                        .catchError((error){
                          print(error);
                          showInSnackBar("Invalid Username or Password");
                        });
                        
                      },
                    )
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  P( text: "Don't have account? ", ),
                  GestureDetector(
                    child: P(text: "Register now"),
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );

  }
}