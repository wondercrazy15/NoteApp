import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Calculator extends StatefulWidget{
  @override
  State createState()=> _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var s1=0,s2=0,sum=0;
  final TextEditingController t1=new TextEditingController(text: "0");
  final TextEditingController t2=new TextEditingController(text: "0");
  void doAddition()
  {
    setState(() {
      s1=int.parse(t1.text);
      s2=int.parse(t2.text);
      sum=s1+s2;
    });
  }
  void doDiv()
  {
    setState(() {
      s1=int.parse(t1.text);
      s2=int.parse(t2.text);
      sum=s1~/s2;
    });
  }
  void doMul()
  {
    setState(() {
      s1=int.parse(t1.text);
      s2=int.parse(t2.text);
      sum=s1*s2;
    });
  }
  void doSub()
  {
    setState(() {
      s1=int.parse(t1.text);
      s2=int.parse(t2.text);
      sum=s1-s2;
    });
  }
  void doClear()
  {
    setState(() {
      t1.text="0";
      t2.text="0";
      sum=0;
    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculator")
      ),
      body: new Container(

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(40),
            child: new Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Output : $sum",
                      style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent),
                    ),


                  ],
                ),

                new TextField(
                  keyboardType: TextInputType.number,
                  controller: t1,
                  decoration: new InputDecoration(hintText: "Enter number 1"),
                ),
                new TextField(
                  controller: t2,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(hintText: "Enter number 2"),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new MaterialButton(
                      child: new Text("+"),
                      textColor: Colors.white,
                      color: Colors.lightBlueAccent,
                      onPressed: doAddition,
                    ),
                    new MaterialButton(
                        child: new Text("-"),
                        textColor: Colors.white,
                        color: Colors.lightBlueAccent,
                        onPressed: doSub
                    ),

                  ],

                ),
                new Padding(padding: const EdgeInsets.only(top: 20)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new MaterialButton(
                        child: new Text("*"),
                        textColor: Colors.white,
                        color: Colors.lightBlueAccent,
                        onPressed: doMul
                    ),
                    new MaterialButton(
                      child: new Text("/"),
                      textColor: Colors.white,
                      color: Colors.lightBlueAccent,
                      onPressed: doSub,
                    ),

                  ],

                ),
                new Padding(padding: const EdgeInsets.only(top: 5)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new MaterialButton(onPressed: doClear,
                      color: Colors.lightBlueAccent,
                      child:new Text("Clear"),
                      textColor: Colors.white,
                    )
                  ],
                )
              ],
            ),
          ),
        ) ,
      ),
    );
  }

}