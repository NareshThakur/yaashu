import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;  

import 'package:refnotes/globals.dart' as globals;
import 'package:refnotes/pages/home.dart';
import 'package:refnotes/widgets/text-widget.dart';
import 'package:refnotes/blocs/product_bloc.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var degreeStateKey = List<GlobalKey<_DegreeState>>();
  var certificationStateKey = List<GlobalKey<_CertificationState>>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MainBloc mainBloc = new MainBloc();
  
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();

  bool isLoading;
  
  final databaseReference = Firestore.instance;
  int degreeCount = 0;
  int certificationCount = 0;

  List<Degree> listDegree = new List<Degree>();
  List<Certification> listCertification = new List<Certification>();

  File _image;
  String uploadedFileUrl;
  final picker = ImagePicker();
  Future getImage( source ) async {

    final pickedFile = await picker.getImage( source: source == 'gallery' ? ImageSource.gallery : ImageSource.camera, maxHeight: 200, maxWidth: 200 );

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  showInSnackBar(message){

    _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    firestoreConfiguration();
    
  }

  FirebaseApp app;
  FirebaseStorage storage;
  firestoreConfiguration() async{
    app = await FirebaseApp.configure(
      name: 'project-901916185371',
      options: FirebaseOptions(
        googleAppID: (Platform.isIOS || Platform.isMacOS)
            ? '1:901916185371:ios:614b67caa73444ebb039be'
            : '1:901916185371:android:595fbf45d095ffbcb039be',
        gcmSenderID: '901916185371',
        apiKey: 'AIzaSyBnaKP50Qds035VtHNhSVZCo3pzoZh1b20',
        projectID: 'yaashu-a2fa9',
      ),
    );
    storage = FirebaseStorage(
        app: app, storageBucket: 'gs://yaashu-a2fa9.appspot.com');
  }

  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    // isLoading = false;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Form(
              key: _registerFormKey,
              // autovalidate: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset('images/logo.svg', height: 70,),
                            SizedBox(height: 20),

                            _image == null
                            ? P(text: 'No image selected.')
                            : Image.file(_image, height: 100,),
                            SizedBox(height: 10),
                            // RaisedButton(
                            //   onPressed: getImage,
                            //   child: P(text: 'Choose image', color: Colors.white,),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RawMaterialButton(
                                  onPressed: () {
                                    getImage('camera');
                                  },
                                  elevation: 1.0,
                                  fillColor: globals.primaryColor,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 20.0,
                                    color:Colors.white
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    getImage('gallery');
                                  },
                                  elevation: 1.0,
                                  fillColor: globals.primaryColor,
                                  child: Icon(
                                    Icons.attach_file,
                                    size: 20.0,
                                    color:Colors.white
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                  
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: globals.textStyle,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: emailValidator,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: ("Your Email"),
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
                            if (value.length < 8) {
                              return 'Password must be longer than 8 characters';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            focusColor: Colors.grey[300],
                            fillColor: Colors.grey[300],
                            contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: ("Your password"),
                            labelStyle: globals.textStyle,
                            
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
                          controller: confirmPasswordController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if ( value != passwordController.text ) {
                              return 'Confirm password must match Password.';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            focusColor: Colors.grey[300],
                            fillColor: Colors.grey[300],
                            contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: ("Confirm password"),
                            labelStyle: globals.textStyle,
                            
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
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value.length == 0 ) return 'Enter a valid name.';
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.grey[300],
                            fillColor: Colors.grey[300],
                            contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: ("Your name"),
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
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value.length != 10 ) return 'Phone number must be 10 digit long.';
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.grey[300],
                            fillColor: Colors.grey[300],
                            contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: ("Phone number"),
                            labelStyle: globals.textStyle,
                            hintText: "xxxxxxxxxx",
                            hintStyle: globals.textStyle,
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
                          controller: bioController,
                          textInputAction: TextInputAction.next,
                          maxLines: 5,
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: TextInputType.text,
                          validator: (value){
                            // if(value.length == 0 ) return 'Invalid';
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.grey[300],
                            fillColor: Colors.grey[300],
                            contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            labelText: ("Bio"),
                            labelStyle: globals.textStyle
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  B(text: "Pratice area"),
                  Row(
                    children: [
                      PracticeCheckbox( mainBloc: mainBloc, title: "Allopathy", isChecked: false ),
                      PracticeCheckbox( mainBloc: mainBloc,title: "Ayurveda", isChecked: false ),
                    ],
                  ),
                  Row(
                    children: [
                      PracticeCheckbox( mainBloc: mainBloc, title: "Yoga", isChecked: false ),
                      PracticeCheckbox( mainBloc: mainBloc, title: "Naturopathy", isChecked: false ),
                    ],
                  ),
                  Row(
                    children: [
                      PracticeCheckbox( mainBloc: mainBloc, title: "Unani", isChecked: false ),
                      PracticeCheckbox( mainBloc: mainBloc, title: "Siddha", isChecked: false ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      PracticeCheckbox( mainBloc: mainBloc, title: "Homoeopathy", isChecked: false ),
                      PracticeCheckbox( mainBloc: mainBloc, title: "SOWA - RIGPA", isChecked: false ),
                    ],
                  ),
                  SizedBox(height: 10),
                  B(text: "Degree and Specialization"), 
                  SizedBox(height: 5),
                  
                  Column(
                    children: listDegree.map((e){
                      return Column(
                        children: [
                          SizedBox(height:10),
                          e
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      RaisedButton.icon(
                        
                        onPressed: (){
                          degreeStateKey.add( new GlobalKey<_DegreeState>() );
                          listDegree.add(new Degree( mainBloc: mainBloc, key: degreeStateKey[degreeCount], count: degreeCount, ) );
                          degreeCount++;
                          setState(() {
                            
                          });
                        },
                        icon: Icon(Icons.add, color: Colors.white,),
                        textColor: Colors.white,
                        label: P(text: "Add more", color: Colors.white),
                      ),
                      SizedBox(width:10),
                      RaisedButton.icon(

                        onPressed: (){
                          if( degreeCount == 0 ) return;
                          try {
                            mainBloc.unsetDegree(this, (degreeCount-1));  
                          } catch (e) {
                            print(e);
                          }
                          
                          listDegree.removeAt((degreeCount-1));
                          degreeCount--;
                          setState(() {
                            
                          });
                        },
                        icon: Icon(Icons.delete, color: Colors.white,),
                        textColor: Colors.white,
                        label: P(text: "Remove", color: Colors.white),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.red)
                        ),
                        
                      ),
                    ],
                  ),
                  
                  

                  SizedBox(height: 10),
                  B(text: "Certifications and memberships"),
                  P(text: "Press check button to save certificate.", fontSize: 9),
                  SizedBox(height: 5),
                  Column(
                    children: listCertification.map((e){
                      return Column(
                        children: [
                          SizedBox(height:10),
                          e
                        ],
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      RaisedButton.icon(

                        onPressed: (){
                          print(certificationCount);
                          certificationStateKey.add( new GlobalKey<_CertificationState>() );
                          listCertification.add(new Certification(  mainBloc: mainBloc, key: certificationStateKey[certificationCount], count: certificationCount ) );
                          certificationCount++;
                          setState(() {
                            
                          });
                        },
                        icon: Icon(Icons.add, color: Colors.white,),
                        textColor: Colors.white,
                        label: P(text: "Add more", color: Colors.white),
                        
                      ),
                      SizedBox(width:10),
                      RaisedButton.icon(

                        onPressed: (){
                          
                          if( certificationCount == 0 ) return;
                          listCertification.removeAt((certificationCount-1));
                          try {
                            mainBloc.unsetCertificate(this, (certificationCount-1));  
                          } catch (e) {
                            print(e);
                          }
                          
                          certificationCount--;
                          setState(() {
                            
                          });
                        },
                        icon: Icon(Icons.delete, color: Colors.white,),
                        textColor: Colors.white,
                        label: P(text: "Remove", color: Colors.white),
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colors.red)
                        ),
                        
                      ),
                    ],
                  ),

                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          child: B(text: 'Sign Up', color: Colors.white),
                          color: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric( vertical: 15 ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.blueAccent)
                          ),
                          onPressed: () async{
                            
                            
                            uploadedFileUrl = "";
                            List listDegree = new List();
                            List listCertificate = new List();

                            if( mainBloc.certificate.length > 0 ) {
                              for (var i = 0; i < mainBloc.certificate.length; i++) {
                                listCertificate.add( mainBloc.certificate[i]['certificate'] );
                              }
                            }    
                            if( mainBloc.degree.length > 0 ) {
                              for (var i = 0; i < mainBloc.degree.length; i++) {
                                listDegree.add( mainBloc.degree[i]['degree'] );
                              }
                            }    
                            print( mainBloc.practiceArea );
                            print( listCertificate );
                            print( listDegree );
                            // return;

                            if( _registerFormKey.currentState.validate() ){
                              if( passwordController.text == confirmPasswordController.text ){
                                
                                setState(() {
                                  isLoading = true;
                                });
                                StorageReference storageReference = FirebaseStorage.instance
                                .ref()
                                .child('user_picture/${Path.basename(_image.path)}');

                                StorageUploadTask uploadTask = storageReference.putFile(_image);
                                
                                await uploadTask.onComplete.then((value){
                                  print('Imaage upload');
                                  print(value);  
                                })
                                .catchError((error){
                                  print('File upload error:');
                                  print(error);
                                });
                                print('file uploaded');
                                storageReference.getDownloadURL().then((fileUrl){
                                  setState(() {
                                    uploadedFileUrl = fileUrl;
                                  });
                                  print(uploadedFileUrl);
                                });


                                // return;

                                FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: emailController.text, 
                                  password: passwordController.text
                                )
                                .then((currentUser){
                                  Firestore.instance
                                  .collection("users")
                                  .document(currentUser.user.uid )
                                  .setData({
                                    "uid": currentUser.user.uid,
                                    "name": nameController.text,
                                    "phone": phoneController.text,
                                    "bio": bioController.text,
                                    "profileUrl": uploadedFileUrl,
                                    "practiceArea": mainBloc.practiceArea,
                                    "degree": listDegree,
                                    "certificate": listCertificate
                                  })
                                  .then((result) async{

                                    emailController.clear();
                                    nameController.clear();
                                    passwordController.clear();
                                    confirmPasswordController.clear();
                                    phoneController.clear();
                                    bioController.clear();

                                    Navigator.pushReplacement(
                                      context, 
                                      MaterialPageRoute(builder: (context)=> HomePage() )
                                    );
                                  })
                                  .catchError((error){
                                    print("Firestore Error: ");
                                    print(error);
                                    showInSnackBar(error);
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });

                                })
                                .catchError((error){
                                  print("Firebase auth Error: ");
                                  print(error);
                                  showInSnackBar(error);
                                  setState(() {
                                    isLoading = false;
                                  });
                                });

                              }
                            } else {
                              
                              showInSnackBar("Please fix the error.");
                            }
                          },
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
            isLoading == true
            ? Positioned(
              top: MediaQuery.of(context).size.height * .5,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(backgroundColor: Colors.white, ),
                    SizedBox(height: 10,),
                    P(text: "Please wait while we registering you...", color: Colors.white),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.6)
                ),
              ),
            )
            : SizedBox(height: 0,),
          ],
        ),
      ),

    );

  }
}


class PracticeCheckbox extends StatefulWidget{
  final String title;
  final bool isChecked;
  final MainBloc mainBloc;

  PracticeCheckbox({ Key key, this.mainBloc, this.title, this.isChecked}): super(key: key);

  @override
  _PracticeCheckboxState createState() => _PracticeCheckboxState( mainBloc, title, isChecked);
}

class _PracticeCheckboxState extends State<PracticeCheckbox> {

  final String title;
  final bool isChecked;
  final MainBloc mainBloc;

  _PracticeCheckboxState(this.mainBloc, this.title, this.isChecked);

  bool checkboxValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkboxValue = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Row(
        children: [
          Checkbox(
              value: checkboxValue,
              onChanged: (bool value) {
                setState(() {
                  checkboxValue = value;
                  if( value == true ){
                    mainBloc.setPracticeArea(this, widget.title);
                  } else {
                    mainBloc.unsetPracticeArea(this, widget.title);
                  }
                  
                });
              },
          ),
          P(text: widget.title )
        ],
      )
    );
  }
}

class Degree extends StatefulWidget{
  final MainBloc mainBloc;
  final int count;
  Degree({ Key key, this.mainBloc, this.count }):super(key:key);
  
  @override
  _DegreeState createState() => _DegreeState( mainBloc, count);
}

class _DegreeState extends State<Degree> {
  final MainBloc mainBloc;
  final int count;
  _DegreeState(this.mainBloc, this.count);

  List<String> degree = new List<String>();
  String dropdownValue;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    degree = [ "MD", "BD", "CD" ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DropdownButton<String>( 
      value: dropdownValue,
      isExpanded: true,
      items: degree.map<DropdownMenuItem<String>>((e){
        return DropdownMenuItem<String>(
          value: e,
          child: P(text: e),
        );
      }).toList(),
      onChanged: (value){
        dropdownValue = value;
        mainBloc.setDegree(this, count, value);
      },
    );
  }
}

class Certification extends StatefulWidget{
  final MainBloc mainBloc;
  final int count;
  Certification({Key key, this.mainBloc,this.count}): super(key: key);

  @override
  _CertificationState createState() => _CertificationState(mainBloc, count);
}

class _CertificationState extends State<Certification> {
  final MainBloc mainBloc;
  final int count;
  _CertificationState(this.mainBloc, this.count);
  
  TextEditingController textController = new TextEditingController();
  bool isSaved;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSaved = false;
    
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            style: globals.textStyle,
            controller: textController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            validator: (value){
              if(value.length == 0 ) return 'Invalid';
            },
            onSaved:(value){

            },
            decoration: InputDecoration(
              focusColor: Colors.grey[300],
              fillColor: Colors.grey[300],
              contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              labelText: ("Enter certification"),
              labelStyle: globals.textStyle
            ),
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            mainBloc.setCertificate(this, count, textController.text);
            setState(() {
              isSaved = true;
            });
          },
          elevation: 1.0,
          fillColor: isSaved == true ? Colors.green : Colors.orangeAccent,
          child: Icon(
            Icons.check,
            size: 20.0,
            color: Colors.white,

          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),

        )

      ],
    );
  }
}