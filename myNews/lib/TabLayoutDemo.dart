import 'package:flutter/material.dart';
import 'package:myNews/MyWebView.dart';
import 'package:myNews/ProfilePage.dart';
import 'package:myNews/LoginPage.dart';

class TabLayoutDemo extends StatefulWidget {
   @override
  State<StatefulWidget> createState() {
    return _tablayout();
  }
}

class _tablayout extends State<TabLayoutDemo> {
  MyWebView onePage;
  ProfilePage secondPage;
  int currentTab=0;
  List<Widget> pages;
  Widget currentPage;
  @override
  void initState() {
    super.initState();
    onePage=MyWebView();
    secondPage=ProfilePage();
    pages=[onePage,secondPage];
    currentPage=onePage;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
            body:
              currentPage
            ,

            bottomNavigationBar: BottomNavigationBar(

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
    );
  }

}
