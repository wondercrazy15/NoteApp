import 'package:flutter/material.dart';

class SimpleInterest extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _SimpleInterest();
  }

}
class _SimpleInterest extends State<SimpleInterest>{
  var _formKey=GlobalKey<FormState>();
  var _currencies=['Rupees','Doller','Pound'];
  TextEditingController _Principle=new TextEditingController();
  TextEditingController _RateOfInterest=new TextEditingController();
  TextEditingController _Year=new TextEditingController();
  var _selectedItem="";
  var _result="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedItem=_currencies[0];
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle=Theme.of(context).textTheme.subtitle1;
    return Scaffold(

        appBar: (AppBar(
          title: Text("Simple Interest Calculator")

        )),

        body:
     GestureDetector(
    onTap: () {

    FocusScope.of(context).requestFocus(new FocusNode());
    },

    child:
        Form(
          key: _formKey,
          //margin: EdgeInsets.all(20.0),
         child: Padding(
           padding: EdgeInsets.all(10.0),
             child:
             ListView(
               physics: new ClampingScrollPhysics(),
               children: [
                 Column(
                   children: [
                     Image.asset("assets/images/moneylogo.png",height: 250),
                     TextFormField(keyboardType: TextInputType.number,
                         style: textStyle,
                         controller: _Principle,
                         validator: (String value){
                          if(value.isEmpty){
                            return "Please enter principle ammount";
                          }
                          else if(value.startsWith("0")){
                            return "Please enter valid principle";
                          }
                         },
                         decoration: InputDecoration(
                             labelText: "Principle",
                             hintText: "Enter Principle ex:12000",
                             border:OutlineInputBorder(borderRadius: BorderRadius.circular(5.0) )
                         )
                     ),
                     Padding(
                       padding: EdgeInsets.only(top: 5.00,bottom: 5.00),
                     ),
                     TextFormField(keyboardType: TextInputType.number,
                         style: textStyle,
                         validator: (String value){
                           if(value.isEmpty){
                             return "Please enter Rate of Interest";
                           }
                           else if(value.startsWith("0")||int.parse(value)>50){
                             return "Please enter valid Rate of Interest";
                           }
                         },
                         controller: _RateOfInterest,
                         decoration: InputDecoration(
                             labelText: "Rate of Interest",
                             hintText: "Percentages",
                             border:OutlineInputBorder(borderRadius: BorderRadius.circular(5.0) )
                         )
                     ),
                     Padding(
                       padding: EdgeInsets.only(top: 5.00,bottom: 5.00),
                     ),
                     Row(
                       children: [
                         Expanded(
                           child: TextFormField(keyboardType: TextInputType.number,
                               controller: _Year,
                               validator: (String value){
                                 if(value.isEmpty){
                                   return "Please enter Year";
                                 }
                                 else if(value.startsWith("0")){
                                   return "Please enter valid year";
                                 }
                               },
                               style: textStyle,
                               decoration: InputDecoration(

                                   labelText: "Term",
                                   hintText: "Time in Year",
                                   border:OutlineInputBorder(borderRadius: BorderRadius.circular(5.0) )
                               )
                           ),
                         ),
                         Container(
                           padding: EdgeInsets.all(10.0),
                         ),
                         Expanded(
                           child: DropdownButton<String>(

                             isExpanded: true,
                             items: _currencies.map((String value) {
                               return DropdownMenuItem<String>(
                                 value:value,
                                 child: Text(value, style: textStyle,),
                               );
                             }).toList(),
                             value: _selectedItem,
                             onChanged: (String SelectedItem){
                               setState(() {
                                 _selectedItem=SelectedItem;
                               });
                             },
                           ),

                         ),
                       ],
                     ),
                     Padding(
                       padding: EdgeInsets.only(top: 5.00,bottom: 5.00),
                     ),
                     Row(
                       children: [
                         Expanded(
                           child: RaisedButton(
                             padding: EdgeInsets.all(15.0),
                             child: Text("Calculate" ),
                             onPressed: (){
                               _submit();
                             },

                             textColor: Colors.white,
                             color: Colors.blueAccent,
                           ),
                         ),
                         Container(
                           padding: EdgeInsets.all(3.0),
                         ),
                         Expanded(
                           child: RaisedButton(
                             padding: EdgeInsets.all(15.0),
                             child: Text("Reset"),
                             onPressed: (){
                               _reset();
                             },
                           ),
                         )
                       ],
                     ),
                     Text(_result),
                   ],
                 ),
               ],
             )
         ),
        ),),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(left:10 ),
          child: ListView(
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child:Image.asset("assets/images/jasmin.jpeg",width: 150,height: 150),),),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10.0),),
              Text("Jasmin Sojitra",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize:18 )),
            ],
          ),
        )
      ),
    );
  }

  void _submit() {
    setState(() {

     if(_formKey.currentState.validate()){
       double year=double.parse(_Year.text);
       double interst=double.parse(_RateOfInterest.text);
       double amount=double.parse(_Principle.text);
       double finalAmount=amount+(amount*year*interst)/100;
       _result='Aftre $year Year, your investment will be worth $finalAmount $_selectedItem';
     }

    });
  }

  void _reset() {
    setState(() {
      _formKey.currentState.reset();
      _Principle.text="";
      _RateOfInterest.text="";
      _Year.text="";
      _selectedItem=_currencies[0];
      _result="";
    });
  }

}