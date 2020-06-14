import 'package:flutter/material.dart';
import 'package:refnotes/models/CallHelper.dart';
import 'package:refnotes/models/CallItemModel.dart';
import 'package:refnotes/models/ChatHelper.dart';
import 'package:refnotes/models/ChatItemModel.dart';
import 'package:refnotes/models/StatusHelper.dart';
import 'package:refnotes/models/StatusItemModel.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:refnotes/pages/add_article.dart';
import 'package:refnotes/pages/add_notes.dart';
import 'package:refnotes/pages/add_patient.dart';
import 'package:refnotes/pages/login.dart';
import 'package:refnotes/pages/profile.dart';
import 'package:refnotes/widgets/text-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget{
  final String currentUser;
  HomePage({Key key, this.currentUser}): super(key: key);

  @override
  _HomePageState createState() => _HomePageState(currentUser);
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final String currentUser;
  _HomePageState(this.currentUser);

  // Color whatsAppGreen = globals.primaryColor;
  // Color whatsAppGreenLight = Color.fromRGBO(110, 160, 235, 1.0);
  TabController tabController;
  var fabIcon = Icons.add;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              fabIcon = Icons.add;
              break;
            case 1:
              fabIcon = Icons.add;
              break;
            case 2:
              fabIcon = Icons.add;
              break;
          }
        });
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
          IconButton(
            onPressed: (){
              FirebaseAuth.instance
              .signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ],
        // backgroundColor: whatsAppGreen,
        bottom: TabBar(
          
          tabs: [
            
            // Tab(
            //   icon: Icon(Icons.camera_alt),
            // ),
            Tab(
              child: P(text: "Patient", color: Colors.white,),
            ),
            Tab(
              child: P( text: "Articles", color: Colors.white)
            ),
            Tab(
              child: P( text: "My profile", color: Colors.white )
            ),
          ],
          indicatorColor: Colors.white,
          controller: tabController,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // Icon(Icons.camera_alt),
          ListView.builder(
            itemBuilder: (context, position) {
              ChatItemModel chatItem = ChatHelper.getChatItem(position);

              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNotesPage(),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            size: 50.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      B( text: chatItem.name,),
                                      P( text: chatItem.messageDate,),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: P( text: chatItem.mostRecentMessage ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
            itemCount: ChatHelper.itemCount,
          ),
        ListView.builder(
          itemBuilder: (context, position) {
            StatusItemModel statusItemModel = StatusHelper.getStatusItem(position);

            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  B( text: statusItemModel.name, ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: P( text: statusItemModel.excerpt),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          P(text: statusItemModel.articleTime, fontSize: 10),
                          P(text: statusItemModel.articleDate, fontSize: 10),
                        ],
                      )
                      // Icon(
                      //   Icons.account_circle,
                      //   size: 64.0,
                      // ),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          },
          itemCount: StatusHelper.itemCount,
        ),
          ProfilePage( currentUser: currentUser )
          // ListView.builder(
          //   itemBuilder: (context, position) {
          //     CallItemModel callItemModel = CallHelper.getCallItem(position);

          //     return Column(
          //       children: <Widget>[
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Row(
          //             children: <Widget>[
          //               Icon(
          //                 Icons.account_circle,
          //                 size: 64.0,
          //               ),
          //               Expanded(
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(8.0),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: <Widget>[
          //                       Column(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: <Widget>[
          //                           Row(
          //                             mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                             children: <Widget>[
          //                               Text(
          //                                 callItemModel.name,
          //                                 style: TextStyle(
          //                                     fontWeight: FontWeight.w500,
          //                                     fontSize: 20.0),
          //                               ),
          //                             ],
          //                           ),
          //                           Padding(
          //                             padding: const EdgeInsets.only(top: 2.0),
          //                             child: Text(
          //                               callItemModel.dateTime,
          //                               style: TextStyle(
          //                                   color: Colors.black45, fontSize: 16.0),
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                       Icon(Icons.call)
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //         Divider(),
          //       ],
          //     );
          //   },
          //   itemCount: CallHelper.itemCount,
          // ),
        
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(tabController.index);
          switch (tabController.index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPatientPage(),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddArticlePage(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
              break;
            default:
          }
        },
        child: Icon(fabIcon),
        // backgroundColor: whatsAppGreenLight,
      ),
    );
  }

}