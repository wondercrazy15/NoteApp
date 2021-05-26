import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CurrenLocation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CurrentLocation();
  }

}

class _CurrentLocation extends State<CurrenLocation>{

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  TextEditingController locationController = TextEditingController();
  String YourLocation="";
  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;

    _location.onLocationChanged.listen((l) {
      _initialcameraposition=LatLng(l.latitude,l.longitude);
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
        ),
      );

      setState(() {
        _markers.clear();
        final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(l.latitude, l.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
        );
        _markers["Current Location"] = marker;
      });
      getCurrentAddress();
    });
  }


  final Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Stack(
            children: [

              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: _initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                markers: _markers.values.toSet(),
              ),
              Positioned(
                top: 20.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: locationController,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 5, top: 0),
                        width: 10,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                      ),
                      hintText: "pick up",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 0, top: 0.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  List<Address> results = [];
  getCurrentAddress() async
  {

    final coordinates = new Coordinates(_initialcameraposition.latitude, _initialcameraposition.longitude);
    results  = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;

    print("${first.featureName} ");
    print(" ${first.addressLine}");
    if(first!=null) {
      var address;
      address = first.addressLine;
//      address =   " $address, ${first.subLocality}" ;
//      address =  " $address, ${first.subLocality}" ;
//      address =  " $address, ${first.locality}" ;
//      address =  " $address, ${first.countryName}" ;
//      address = " $address, ${first.postalCode}" ;
      setState(() {
        locationController.text = address;

      });
      print(address);
    }
  }
}