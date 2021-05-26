import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:myNews/models/note.dart';
import 'package:myNews/utils/database_helper.dart';
import 'package:myNews/CustomDialogBox.dart';
class note_detail extends StatefulWidget{
  String AppBarTitle;
  final Note note;

  note_detail(this. note, this.AppBarTitle);
  @override
  State<StatefulWidget> createState() {
    return _note_detail(note,this.AppBarTitle);
  }

}

class _note_detail extends State<note_detail>{

  DatabaseHelper helper = DatabaseHelper();
  Note note;
  String AppBarTitle;
  static var _priority=['High','Low'];
  String selectedItem="Low";
  TextEditingController titleController=new TextEditingController();
  TextEditingController descriptionController=new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _note_detail(this.note, this.AppBarTitle);
  var _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    titleController.text = note.title;
    descriptionController.text = note.description;
    TextStyle textstyle=Theme.of(context).textTheme.subtitle1;
    FocusNode textDescriptionFocusNode = new FocusNode();
    return WillPopScope(
      onWillPop: (){back();},
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(AppBarTitle),
            leading: IconButton(icon: Icon(Icons.arrow_back),color: Colors.white,
              onPressed: (){
                back();
              },),
          ),
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child:

    Form(
    key: _formKey,
        child:  Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: [
                new Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: new BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(2.0)),
                        border: new Border.all(color: Colors.black38)
                    ),
                    child: DropdownButtonHideUnderline(
                        child:Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:  DropdownButton(
                           
                            isExpanded: true,

                            items: _priority.map((String DropDownStringItem){
                              return DropdownMenuItem<String>(
                                value: DropDownStringItem,

                                child: Text(DropDownStringItem),
                              );
                            }).toList(),

                            style: textstyle,
                            value: getPriorityAsString(note.priority),
                            onChanged:(selectedDropDownItem){
                              setState(() {
                                updatePriorityAsInt(selectedDropDownItem);
                              });
                            },

                          ),
                        )

                    )


                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: (
                      TextFormField(
                        controller: titleController,
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context).requestFocus(textDescriptionFocusNode);
                        },
                        validator: (String value){
                          if(value.isEmpty){
                            return "Please enter Title of Note";
                          }
                          else
                            return null;
                          },
                        style: textstyle,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                            labelText: "Title",
                            labelStyle: textstyle,
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                        onChanged: (titleValue){
                          updateTitle();
                        },
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: (
                      TextFormField(
                        focusNode: textDescriptionFocusNode,
                        controller: descriptionController,
                        style: textstyle,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        validator: (String value){
                          if(value.isEmpty){
                            return "Please enter Description of Note";
                          }
                          else
                            return null;
                        },
                        minLines: 2,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            labelText: "Description",
                            labelStyle: textstyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                        onChanged: (titleValue){
                          updateDescription();
                        },
                      )
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: (
                        Row(
                          children: [
                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,

                                child: Text(
                                  'Save',textScaleFactor: 1.5,
                                ),
                                onPressed: (){
                                  setState(() {
                                      _save();
                                  });
                                },
                              ),
                            ),
                            Container(width: 5.0,),
                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: Text(
                                  'Delete',textScaleFactor: 1.5,
                                ),
                                onPressed: (){
                                  if (note.id != null) {
                                    setState(() {
                                      _delete();
                                    });
                                  }

                                },
                              ),
                            ),
                          ],
                        )
                    )
                ),
              ],
            ),
          )
    ),
        ),
    ));
  }
  void back() {
    Navigator.pop(context,true);
  }
// Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priority[0];  // 'High'
        break;
      case 2:
        priority = _priority[1];  // 'Low'
        break;
    }
    return priority;
  }

  // Update the title of Note object
  void updateTitle(){
    note.title = titleController.text;
  }

  // Update the description of Note object
  void updateDescription() {
    note.description = descriptionController.text;
  }

  // Save data to database
  void _save() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.reset();
      back();

      var d = new DateFormat.yMMMMd('en_US').format(DateTime.now());
      note.date = new DateFormat.yMd().add_jm().format(DateTime.now());
      int result;
      if (note.id != null) { // Case 1: Update operation
        result = await helper.updateNote(note);
      } else { // Case 2: Insert Operation
        result = await helper.insertNote(note);
      }

      if (result != 0) { // Success
        if(note.id!=null)
          {

            showDialog(context: context,
                builder: (BuildContext context){
                  return CustomDialogBox(
                    title: "Status ",
                    descriptions: "Note Edited Successfully",
                    text: "Ok",
                  );
                }
            );
           // _showAlertDialog('Status', 'Note Edited Successfully');
          }
        else{
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Status ",
                  descriptions: "Note added Succesfully",
                  text: "Ok",
                );
              }
          );
        }
          //_showAlertDialog('Status', 'Note Saved Successfully');
      } else { // Failure
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "Status ",
                descriptions: "Problem Saving Note",
                text: "Ok",
              );
            }
        );

      }

    }

  }

  void _delete() async {

    back();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');

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
  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}

