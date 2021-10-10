import 'dart:async';

import 'package:exploress/data/map_data/gps_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  final LatLng? initialPosition;

  MapSample({this.initialPosition});

  static Route route({LatLng? initialPosition}) {
    return MaterialPageRoute<void>(builder: (_) => MapSample(initialPosition: initialPosition,));
  }


  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  /*static final CameraPosition _kGooglePlex = CameraPosition(
    target: GPSLocation.myCurrentPosition().,
    zoom: 14.4746,
  );*/

  Future<Marker> customHueFromAssets() async{
    return Marker(
        markerId: MarkerId("custom"),
        position: LatLng(-11.632200, 27.560340),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5),
            'asset/icons/shop_hue.png'
        )
    );
  }

  Future<LatLng> defaultLshi() async{
    return LatLng(-11.632240, 27.460640);
  }

  Future<LatLng> currentPosition() async {
    return (await GPSLocation.myCurrentPosition()).latLng;

  }

//-11.6284708 + 27.484585699999997
  static final CameraPosition _kLshi = CameraPosition(
      target: LatLng(-11.632240, 27.460640),
      zoom: 13.0
  );
  static final CameraPosition _kLksi = CameraPosition(
      target: LatLng(-10.982720, 26.737591),
      zoom: 15.0);
  static final CameraPosition prostyle243 = CameraPosition(
      target: LatLng(-10.982720, 26.737591),
      zoom: 15.0);

  Set<Marker> markers = <Marker>{

    Marker(
      markerId: MarkerId("first_pos"),
      position: LatLng(-10.982720, 26.737591),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: MarkerId("sec_pos"),
      position: LatLng(-11.672300, 27.460540),
      icon: BitmapDescriptor.defaultMarker,
    ),
    Marker(
      markerId: MarkerId("tri_pos"),
      position: LatLng(-11.6284708, 27.487585),
      icon: BitmapDescriptor
          .defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    ),

  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //top: false,
      child: new Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: FutureBuilder<LatLng>(
            future: defaultLshi() ,
            initialData:_kLshi.target,
            builder: (context, snapshot) {
              if(snapshot.hasData)
                return GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      bearing: 192.8334901395799,
                      target: widget.initialPosition ?? snapshot.data!,
                      //tilt: 59.440717697143555,
                      zoom: 15.151926040649414
                  ),
                  markers: markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              return Container(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          //mini: true,
          onPressed: _goToMyPosition,
          //label: Text('To the lake!'),
          child: Icon(Icons.gps_fixed),
          backgroundColor: Colors.cyan.withOpacity(0.5),
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Theme.of(context).primaryColor,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.person_outline_outlined,),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.map,),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Future<void> _goToMyPosition() async {
    final GoogleMapController controller = await _controller.future;
    var pos = await GPSLocation.myCurrentPosition();
    /*setState(() {
      markers.add(Marker(
        markerId: MarkerId("my_pos"),
        position: pos.latLng,
        infoWindow: InfoWindow(title: "Me"),
        zIndex: 10.0,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      ),);
    });*/
    final CameraPosition _kPos = CameraPosition(
        bearing: 192.8334901395799,
        target: pos.latLng,
        //tilt: 59.440717697143555,
        zoom: 15.151926040649414
    );
    print('${pos.latitude } + ${pos.longitude}');
    controller.animateCamera(CameraUpdate.newCameraPosition(_kPos));
  }
}