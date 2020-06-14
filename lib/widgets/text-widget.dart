import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  const TitleText({Key key, this.text, this.fontSize = 16, this.color = Colors.black87, this.fontWeight = FontWeight.w600, this.decoration })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.muli(
        fontSize: fontSize, 
        fontWeight: fontWeight, 
        color: color,
        decoration: decoration
      ),
      overflow: TextOverflow.fade  
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  const SubtitleText({ Key key, this.text, this.fontSize = 10, this.color = Colors.black45, this.fontWeight = FontWeight.w600, this.decoration }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.muli(
        fontSize: fontSize, 
        fontWeight: fontWeight, 
        color: color, 
        decoration: decoration 
      ),
      overflow: TextOverflow.fade  
    );
  }
}

class P extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  const P({Key key, this.text, this.fontSize = 13, this.color = Colors.black87, this.fontWeight = FontWeight.w400, this.decoration }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.muli(
        fontSize: fontSize, 
        fontWeight: fontWeight, 
        color: color, 
        decoration: decoration 
      ), 
      overflow: TextOverflow.fade  
    );
  }
}

class B extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  const B({ Key key, this.text, this.fontSize = 13, this.color = Colors.black87, this.fontWeight = FontWeight.w800, this.decoration }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.muli(
        fontSize: fontSize, 
        fontWeight: fontWeight, 
        color: color, 
        decoration: decoration
      ),
      overflow: TextOverflow.fade  
    );
  }
}