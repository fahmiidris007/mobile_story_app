import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_story_app/common.dart';
import 'package:mobile_story_app/screen/story/detail/widget/place_mark_widget.dart';

class MapsViewWidget extends StatefulWidget {
  final double lat;
  final double lon;

  const MapsViewWidget({super.key, required this.lat, required this.lon});

  @override
  State<MapsViewWidget> createState() => _MapsViewWidgetState();
}

class _MapsViewWidgetState extends State<MapsViewWidget> {
  late GoogleMapController mapController;
  geo.Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    if (widget.lat == 0.0 && widget.lon == 0.0) return const SizedBox();
    return Column(
      children: [
         Text(
          AppLocalizations.of(context)!.mapsLocation,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.lon),
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  mapController = controller;
                  mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(widget.lat, widget.lon),
                        zoom: 15,
                      ),
                    ),
                  );
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('id'),
                    position: LatLng(widget.lat, widget.lon),
                    onTap: () async {
                      final info = await geo.placemarkFromCoordinates(widget.lat, widget.lon);
                      setState(() {
                        placemark = info[0];
                      });
                    },
                  ),
                },
              ),
              if (placemark == null)
                const SizedBox.shrink()
              else
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: DetailPlacemarkWidget(
                    placemark: placemark!,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}