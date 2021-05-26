import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _profilePage();
  }

}

class _profilePage extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage>{
  File _image;
  final picker = ImagePicker();

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final bytes = _image.readAsBytesSync();
        String _img64 = base64Encode(bytes);
      } else {
        print('No image selected.');
      }
    });

  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final bytes = _image.readAsBytesSync();
        String _img64 = base64Encode(bytes);
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    TextStyle textstyle=Theme.of(context).textTheme.subtitle1;

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body:
    SingleChildScrollView(
    child:
        Column(
      children: <Widget>[
      SizedBox(
        height: 32,
      ),
      Center(
        child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: CircleAvatar(
            radius: 55,
            backgroundColor: Colors.lightBlueAccent,
            child: _image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                _image,
                width: 100,
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            )
                : Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50)),
              width: 100,
              height: 100,
              child: Icon(
                Icons.perm_identity,
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
      ),

        new Form(
            child:

                new Container(
                  padding: const EdgeInsets.all(20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(

                        validator: (String value){
                          if(value.isEmpty){
                            return "Please enter First Name";
                          }
                          else
                            return null;
                        },
                        style: textstyle,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            labelText: "Enter First Name",
                            labelStyle: textstyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (titleValue){

                        },
                      ),

                      new Padding(padding: const EdgeInsets.only(top:10.0)),
                      TextFormField(

                        validator: (String value){
                          if(value.isEmpty){
                            return "Please enter Last Name";
                          }
                          else
                            return null;
                        },
                        style: textstyle,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            labelText: "Enter Last Name",
                            labelStyle: textstyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (titleValue){

                        },
                      ),
                      new Padding(padding: const EdgeInsets.only(top:10.0)),
                      TextFormField(

                        validator: (String value){
                          if(value.isEmpty){
                            return "Please Enter Email";
                          }
                          else
                            return null;
                        },
                        style: textstyle,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            labelText: "Enter Email",
                            labelStyle: textstyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0)
                            )
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (titleValue){

                        },
                      ),

                      new Padding(padding: const EdgeInsets.only(top:20.0)),
                      ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: double.infinity),
                        child: MaterialButton(onPressed: ()=>{},
                          height: 40,
                          textColor: Colors.white,
                          color: Colors.blue,
                          child: new Text("Update",style: TextStyle(color: Colors.white,fontSize: 18)),
                        ),
                      )

                    ],
                  ),
                )
            )


      ],

      ),)
    ),);
  }
  void back() {
    Navigator.pop(context,true);
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  bool get wantKeepAlive => true;

}