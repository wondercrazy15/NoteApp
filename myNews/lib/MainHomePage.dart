import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myNews/note_detail.dart';
import 'package:myNews/ProfilePage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:myNews/models/note.dart';
import 'package:myNews/utils/database_helper.dart';
import 'package:myNews/models/Payload.dart';
import 'package:myNews/TabLayoutDemo.dart';
import 'package:myNews/DrawerPage.dart';

import 'note_list.dart';
class MainHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainHomePage();
  }

}

class _MainHomePage extends State<MainHomePage>{

  PageController _pageController;
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
        // Do whatever you like with the page value
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DatabaseHelper databaseHelper=DatabaseHelper();
  List<Note> noteList;
  int count=0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedChoices;
  final List<Payload> payloadList = [
    Payload(
      title: "Title 1",
      imageUrl: 'assets/images/note1.jpg',
    ),
    Payload(
      title: "Title 2",
      imageUrl:  'assets/images/note2.jpg',
    ),
    Payload(
      title: "Title 3",
      imageUrl: 'assets/images/note3.jpg',
    ),
    Payload(
      title: "Title 3",
      imageUrl: 'assets/images/note4.jpg',
    ),
    Payload(
      title: "Title 3",
      imageUrl: 'assets/images/note5.jpg',
    ),
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if(noteList==null){
      noteList=List<Note>();
      updateListView();
    }
    const List<String> choices = <String>[
      "Add Note",
      "Profile",
      "Setting"
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar:AppBar(
        title: Text("Note List"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white,),
            onSelected: _select,
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (BuildContext context) {
              return choices.map((String choice) {
                return  PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );}
              ).toList();
            },
            offset: Offset(0, 40),
          )
        ],
      ),
      body:
      PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          note_list(),
          ProfilePage(),
        ],
      ),
      drawer: DrawerPage(_pageController),
      //getListView(),
    );
  }

  void _select(String choice) {
    setState(() {
      _selectedChoices = choice;
      switch (_selectedChoices) {
        case "Add Note":
          navigateToDetail(Note('', '', 2), 'Add Note');
          break;
        case "Profile":
          navigateToProfilePage();
          break;
        case "Setting":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TabLayoutDemo()),
          );
          break;
      }
    });
  }




  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return note_detail(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }
  void navigateToProfilePage() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProfilePage();
    }));
  }
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });

  }


}



