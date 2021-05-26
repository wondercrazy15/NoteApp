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
class note_list extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _note_list();
  }

}

class _note_list extends State<note_list>{
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
      body:
          Container(
            child:
            Column(
              children: [
                  CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    aspectRatio: 2.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),

                  items: payloadList.map((payload) {
                    return Builder(builder: (BuildContext context) {
                      return Column(

                        children: <Widget>[
                          Padding( padding: EdgeInsets.only(top: 10.0),),
//                          Text(payload.title),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Image.asset(
                                payload.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                        ],
                      );
                    });
                  }).toList(),
                ),

                Divider(
                    color: Colors.black26
                ),
                Expanded( child:

                getListView(),
              ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
      ),
        //getListView(),
    );
  }


  ListView getListView() {
    TextStyle textStyle=Theme.of(context).textTheme.headline6;
    return ListView.builder(
        physics: new ClampingScrollPhysics(),
      itemCount: count,
      itemBuilder: (BuildContext build,int position){
        return Card(
            color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),
            title: Text(this.noteList[position].title, style: textStyle,),

            subtitle: Text(this.noteList[position].date),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.black38,),
              onTap: () {
                showAlert(context,position, noteList[position]);

              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.noteList[position],'Edit Note');
            },
          ),
        );
      }
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

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      updateListView();
      _showScaffold('Note Deleted Successfully');
    }
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(duration: const Duration(seconds: 1),
      content: Text(message,textAlign: TextAlign.center,style: TextStyle(fontSize: 18)),
      backgroundColor: Colors.blue,
    ));
  }
  void _showScaffoldRed(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(duration: const Duration(seconds: 1),
      content: Text(
          message, textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18)),
      backgroundColor: Colors.red,
    ));
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

  showAlert(BuildContext context,int pos,Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(

            children: [

            Text('Delete Note',textAlign: TextAlign.center,),
//            Divider(
//                color: Colors.black
//            ),
          ],),

          content: Text("Are You Sure you Want To Delete ?"),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.black26)
              ),
              child: Text("YES"),
              onPressed: () {
                _delete(context, noteList[pos]);
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: Text("NO"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.black26)
              ),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),

//            FlatButton(
//              child: Text("CANCEL"),
//              onPressed: () {
//                //Put your code here which you want to execute on Cancel button click.
//                Navigator.of(context).pop();
//              },
//            ),
          ],
        );
      },
    );
  }

}



