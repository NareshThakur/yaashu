import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refnotes/globals.dart' as globals;
import 'package:refnotes/widgets/text-widget.dart';
import 'package:image_picker/image_picker.dart';

class AddPatientPage extends StatefulWidget{
  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery );

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: SvgPicture.asset('images/logo.svg', color: Colors.white, height: 50,),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_vert),
          ),
        ],
        // backgroundColor: whatsAppGreen,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height:10),
                TitleText(text: "Add patient"),
                SizedBox(height:10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _image == null
                          ? P(text: 'No image selected.')
                          : Image.file(_image, height: 100,),
                          SizedBox(height: 10),
                          RaisedButton(
                            onPressed: getImage,
                            child: P(text: 'Choose image', color: Colors.white),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height:10),
                P(text: "Name"),
                SizedBox(height:5),
                TextFormField(
                  style: globals.textStyle,
                  // controller: firstnameController,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value.length == 0 ) return 'Invalid';
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.grey[300],
                    fillColor: Colors.grey[300],
                    contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // labelText: ("Title"),
                    labelStyle: globals.textStyle
                  ),
                ),
                SizedBox(height:10),
                P(text: "Phone"),
                SizedBox(height:5),
                TextFormField(
                  style: globals.textStyle,
                  textAlignVertical: TextAlignVertical.top,
                  // controller: firstnameController,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value.length == 0 ) return 'Invalid';
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.grey[300],
                    fillColor: Colors.grey[300],
                    contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 10 ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // labelText: ("Title"),
                    labelStyle: globals.textStyle
                  ),
                ),
                SizedBox(height:10),
                P(text: "Description"),
                SizedBox(height:5),
                TextFormField(
                  style: globals.textStyle,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 10,
                  // controller: firstnameController,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  validator: (value){
                    if(value.length == 0 ) return 'Invalid';
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.grey[300],
                    fillColor: Colors.grey[300],
                    contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 5 ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    // labelText: ("Title"),
                    labelStyle: globals.textStyle
                  ),
                ),
                SizedBox(height:20),
              ],
            ),
            
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                    onPressed: (){

                    },
                    // color: globals.primaryColor,
                    child: P(text: "Save", color: Colors.white),
                  )
                )
              ],
            )
            
          ],
        ),
      ),
    );
  }
}