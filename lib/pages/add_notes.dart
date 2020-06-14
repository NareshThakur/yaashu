import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refnotes/globals.dart' as globals;
import 'package:refnotes/models/NoteHelper.dart';
import 'package:refnotes/models/NoteItemModel.dart';
import 'package:refnotes/widgets/text-widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:refnotes/models/ChatItemModel.dart';
import 'package:refnotes/models/ChatHelper.dart';

class AddNotesPage extends StatefulWidget{
  @override
  _AddNotesPageState createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {

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
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Expanded(
              flex:9,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: NoteHelper.itemCount,
                itemBuilder: (context, position){
                  NoteItemModel noteItem = NoteHelper.getNoteItem(position);

                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom:10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: Colors.grey[400]
                      )
                    ),
                    child: Column(
                      children: [
                        P(text: noteItem.note ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            B(text: "Added on: ",),
                            P(text: noteItem.noteTime +" "+ noteItem.noteDate,),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      
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
                        contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 25 ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelStyle: globals.textStyle,
                        hintText: "Type a message",
                        hintStyle:  globals.textStyle,
                        
                      ),
                      
                    )
                  ),
                  
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 1.0,
                    fillColor: globals.primaryColor,
                    child: Icon(
                      Icons.send,
                      size: 20.0,
                      color: Colors.white,

                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),

                  )
                  
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}