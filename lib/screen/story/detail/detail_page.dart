import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_story_app/common.dart';
import 'package:mobile_story_app/provider/story_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StoryDetailProvider>().fetchStoryDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryDetailProvider>(builder: (context, state, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.detailTitle),
        ),
        body: _buildBody(state),
      );
    });
  }

  Widget _buildBody(StoryDetailProvider state) {
    if (state.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state.state == ResultState.hasData) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    state.result.story.photoUrl,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                    scale: 2.0,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    },
                  ),
                ),
              ),
              Text(
                state.result.story.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state.result.story.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              if (state.result.story.lat != null &&
                  state.result.story.lon != null)
                MapsViewWidget(
                  lat: state.result.story.lat!,
                  lon: state.result.story.lon!,
                ),
            ],
          ),
        ),
      );
    } else if (state.state == ResultState.noData) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else if (state.state == ResultState.error) {
      return Center(
        child: Material(
          child: Text(state.message),
        ),
      );
    } else {
      return Center(
          child: Text(AppLocalizations.of(context)!.errorDescription));
    }
  }
}

class MapsViewWidget extends StatefulWidget {
  final double lat;
  final double lon;

  const MapsViewWidget({super.key, required this.lat, required this.lon});

  @override
  State<MapsViewWidget> createState() => _MapsViewWidgetState();
}

class _MapsViewWidgetState extends State<MapsViewWidget> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    if (widget.lat == 0.0 && widget.lon == 0.0) return const SizedBox();
    return Column(
      children: [
        const Text(
          "Maps Location",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: GoogleMap(
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
              ),
            },
          ),
        ),
      ],
    );
  }
}
