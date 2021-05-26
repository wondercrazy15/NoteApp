import 'package:flutter/material.dart';
import 'package:myNews/MyWebView.dart';
import 'package:myNews/ProfilePage.dart';
import 'package:myNews/SimpleInterest.dart';

class MyTab extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyTab> {
  ScrollController _scrollController;
  double _containerMaxHeight = 56, _offset, _delta = 0, _oldOffset = 0;
  MyWebView onePage;
  SimpleInterest secondPage;
  int currentTab=0;
  List<Widget> pages;
  Widget currentPage;
  @override
  void initState() {
    super.initState();
    _offset = 0;
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          double offset = _scrollController.offset;
          _delta += (offset - _oldOffset);
          if (_delta > _containerMaxHeight)
            _delta = _containerMaxHeight;
          else if (_delta < 0) _delta = 0;
          _oldOffset = offset;
          _offset = -_delta;
        });
      });
    onePage=MyWebView();
    secondPage=SimpleInterest();
    pages=[onePage,secondPage];
    currentPage=onePage;
  }


  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        home:
          Scaffold(
            body:
            SafeArea(child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(

                  children: <Widget>[
                    currentPage,
                    Positioned(
                      bottom: _offset,
                      width: constraints.maxWidth,
                      child: Container(
                        width: double.infinity,
                        height: _containerMaxHeight,
                        color: Colors.white,
                        child:  BottomNavigationBar(

                currentIndex: currentTab,
                onTap: (int index){
                setState(() {
                currentTab=index;
                currentPage=pages[index];
                });
                },
                items: <BottomNavigationBarItem>[

                BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home')
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings')
                )
                ],
                ),
                      ),
                    ),
                  ],
                );
              },
            ),),

          )
      );

  }

  Widget _buildItem(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}