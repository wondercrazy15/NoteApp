import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginpageState();
}

class _LoginpageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  String _text="Hello";
  void _btnPress()
  {
    setState(() {
      if(_text.startsWith("H"))
        _text="Welcome";
      else
        _text="Hello";
    });
  }

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState()
  {
    super.initState();
    _iconAnimationController=new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500)
    );
    _iconAnimation= new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.bounceOut
    );
    _iconAnimation.addListener(()=>this.setState(()  { }));
    _iconAnimationController.forward();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      ListView(
        shrinkWrap: true,
        children: [new Stack(
          fit: StackFit.expand,
          children: <Widget>[

            new Image(image: new AssetImage("assets/images/Jasmin.JPG"),
              fit: BoxFit.cover,
              color: Colors.black87,
              colorBlendMode: BlendMode.darken,
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlutterLogo(
                  size: _iconAnimation.value * 100,
                ),
                new Form(
                    child:new Theme(data: new ThemeData(
                        accentColorBrightness: Brightness.dark,
                        primarySwatch: Colors.blue,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0
                            )
                        )
                    ),
                        child: new Container(
                          padding: const EdgeInsets.all(40.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Enter Email"
                                ),style: TextStyle(
                                color: Colors.white,
                              ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Enter Password",
                                ),style: TextStyle(
                                color: Colors.white,
                              ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                              ),
                              new Padding(padding: const EdgeInsets.only(top:40.0)),
                              new MaterialButton(onPressed: ()=>{},
                                height: 40,minWidth: 200,
                                textColor: Colors.white,
                                color: Colors.blue,
                                child: new Text("Login"),
                              )
                            ],
                          ),
                        ))

                )

              ],)
          ],
        ),],
      )


    );
  }
}