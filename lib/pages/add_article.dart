import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refnotes/globals.dart' as globals;
import 'package:refnotes/widgets/text-widget.dart';
class AddArticlePage extends StatefulWidget{
  @override
  _AddArticlePageState createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10),
            TitleText(text: "Add article"),
            SizedBox(height:10),
            P(text: "Title"),
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
                contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 5 ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                // labelText: ("Title"),
                labelStyle: globals.textStyle
              ),
            ),
            SizedBox(height:10),
            P(text: "Content"),
            SizedBox(height:5),
            Expanded(
              flex: 8,
              child: TextFormField(
                style: globals.textStyle,
                maxLines: 30,
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
                  contentPadding: const EdgeInsets.symmetric( vertical: 5, horizontal: 5 ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  // labelText: ("Title"),
                  labelStyle: globals.textStyle
                ),
              ),
            ),
            SizedBox(height:20),
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