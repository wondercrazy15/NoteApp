import 'package:flutter/material.dart';
import 'package:myNews/Constant/AppColor.dart';

class DemoText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoTextState();
  }
}
class _DemoTextState extends State<DemoText>
{
    List<String> _listItems=["Nat food Shop"];
    void addIntoList()
    {
      setState(() {
        _listItems.add("My shop");
      });
    }
    
  @override
  Widget build(BuildContext buildContext){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Demo Of Widget"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(
               children: [
                RaisedButton(
                  child: Text("Add",style: new TextStyle(fontSize: 15.0)),
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  onPressed: addIntoList,
                ),

                 Expanded(
                     child: ListView.builder(
                     shrinkWrap: true,
                     padding: const EdgeInsets.all(5.0),
                     itemCount: _listItems.length,
                     itemBuilder: (context, index) {
                       return Card(

                         child: new Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Image.asset("assets/images/food.jpg", fit: BoxFit.cover,
                               width: MediaQuery
                                   .of(context)
                                   .size
                                   .width - 30,),
                             Container(height: 1,
                                 color: AppColor.DIVIDER_COLOR,
                                 width: MediaQuery
                                     .of(context)
                                     .size
                                     .width - 30),
                             new Padding(padding: const EdgeInsets.all(5.0)),
                             new Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: <Widget>[
                                 new Row(
                                   children: [
                                     new Padding(
                                         padding: const EdgeInsets.only(left: 5.0)),
                                     Icon(Icons.favorite_border,
                                         color: AppColor.ACCENT_COLOR),
                                     new Text(
                                         "Like", style: TextStyle(fontSize: 20)),
                                   ],
                                 ),
                                 new Row(
                                   children: [
                                     Icon(Icons.trip_origin,
                                         color: AppColor.ACCENT_COLOR),
                                     new Text("Veg", style: TextStyle(fontSize: 20)),
                                   ],
                                 ),
                                 new Row(
                                   children: [

                                     Icon(Icons.trip_origin,
                                         color: AppColor.ACCENT_COLOR),
                                     new Text(
                                         "Healthy", style: TextStyle(fontSize: 20)),
                                     new Padding(
                                         padding: const EdgeInsets.only(right: 5.0)),
                                   ],
                                 ),
                               ],
                             ),
                             new Padding(padding: const EdgeInsets.all(5.0)),
                             Container(height: 1,
                                 color: AppColor.DIVIDER_COLOR,
                                 width: MediaQuery
                                     .of(context)
                                     .size
                                     .width - 30),
                             new Padding(padding: const EdgeInsets.only(top: 5)),
                             new Text(_listItems[index], style: new TextStyle(
                                 fontSize: 20, fontWeight: FontWeight.bold)),
                             new Padding(padding: const EdgeInsets.only(bottom: 5)),
                           ],
                         ),
                       );

                     }
                 )),



               ]),


        ),

      ),
    );
  }
}