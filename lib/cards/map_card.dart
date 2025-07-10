

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../utils/util.dart';

class MapCard extends StatefulWidget{
  final LatLng location;

  const MapCard({super.key, required this.location});

  //= LatLng(0.4564, 33.1892);



  @override
  State<StatefulWidget> createState() => _MapCardState();
  
}

class _MapCardState extends State<MapCard>{
  @override
  Widget build(BuildContext context) {
    final LatLng location = widget.location;

    return getMap(context,location);
  }


  Expanded getMap(BuildContext context,LatLng location ) {


    return Expanded(child:

    Row(
      children: [

        Expanded(



          child:

          ClipRRect(
            // borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: Util.scaleWidthFromDesign(context,100) ,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: location,
                  initialZoom: 14.0,
                  interactionOptions:InteractionOptions(
                    flags: InteractiveFlag.flingAnimation,

                  ),

                ),
                children: [
                  //  urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                  //  urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                  //  urlTemplate: 'https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg',
                  // urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  TileLayer(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'com.khoodilabs.cooply',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        // width: 80.0,
                        height: Util.scaleWidthFromDesign(context,20.0) ,
                        point: location,
                        child: Icon(
                          Icons.location_pin,
                          color: Colors.green,
                          size: Util.scaleWidthFromDesign(context,30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),),
        ),

        // ],


      ],
    ),




    );
  }


}