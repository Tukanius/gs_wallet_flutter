import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_score/components/back_button/back_button.dart';
import 'package:green_score/widget/ui/color.dart';

class MapPageArguments {
  double lang;
  double long;
  MapPageArguments({
    required this.lang,
    required this.long,
  });
}

class MapPage extends StatefulWidget {
  final double lang;
  final double long;
  static const routeName = "MapPage";
  const MapPage({super.key, required this.lang, required this.long});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late final CameraPosition _kGooglePlex;
  double langt = 0;
  double longt = 0;
  bool isLoading = true;
  Set<Marker> markers = {};
  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lang, widget.long),
      zoom: 13,
    );
    markers.add(
      Marker(
        markerId: const MarkerId('Location'),
        position: LatLng(widget.lang, widget.long),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Location'),
        onTap: () {},
      ),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        centerTitle: true,
        title: Text(
          'Дэлгүүрийн байршил',
          style: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            CustomBackButton(
              onClick: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: greentext,
              ),
            )
          : GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              markers: Set<Marker>.of(markers),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (mapcontroller) {
                _controller.complete(mapcontroller);
              },
            ),
    );
  }
}
