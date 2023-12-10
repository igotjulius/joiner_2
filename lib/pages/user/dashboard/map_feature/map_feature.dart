import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapFeature extends StatefulWidget {
  const MapFeature({super.key});

  @override
  State<MapFeature> createState() => MapFeatureState();
}

class MapFeatureState extends State<MapFeature> {
  String MAPBOX_ACCESS_TOKEN =
      'pk.eyJ1Ijoiam9pbmVyIiwiYSI6ImNsbWN6eHpkeTE0dGczZG1iOGZlb2drdnUifQ.7R0izGL1KjW64Un0DeC8Gg';
  MapboxMapController? _mapController;
  String _mapStyle = 'mapbox://styles/joiner/clmemo810014b01r8h9ps0et3';
  String? _featureName;
  String? _featureType;

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    _mapController!.onSymbolTapped.add((argument) {
      print('FUCKING ${argument.id}');
    });
  }

  void _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Style loaded :)"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  void _onFeatureClick(Map<String, dynamic> feature) {
    final [longitude, latitude] = feature['geometry']['coordinates'];
    print(feature);
    _featureName = feature['properties']['name'];
    _featureType = feature['properties']['type'];
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        // lat - value -> offset from top, long + value -> offset from right
        CameraPosition(
          target: LatLng(latitude, longitude + 0.08),
          zoom: _mapController!.cameraPosition!.zoom,
        ),
      ),
    );
  }

  bool _showSelection = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onPanUpdate: (drag) {
          setState(() {
            _showSelection = false;
          });
        },
        child: Stack(
          children: [
            mapboxMap(),
            if (_showSelection)
              Positioned.fill(
                bottom: -160,
                right: -100,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 240,
                    width: 260,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_featureName!),
                            Text(_featureType!),
                            Text(
                              'Create a plan',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Set this as your destination',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: TextButton(
                                onPressed: () {
                                  context.pushNamed('LobbyCreation',
                                      extra: {'destination': _featureName});
                                },
                                child: Text('Create lobby'),
                              ),
                            ),
                          ].divide(
                            SizedBox(
                              height: 4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget mapboxMap() {
    return MapboxMap(
      styleString: _mapStyle,
      accessToken: MAPBOX_ACCESS_TOKEN,
      onMapCreated: _onMapCreated,
      initialCameraPosition:
          const CameraPosition(target: LatLng(10.26, 123.665), zoom: 8),
      onStyleLoadedCallback: _onStyleLoadedCallback,
      onMapClick: (point, latLng) async {
        setState(() {
          _showSelection = false;
        });
        print(
            "Map click: ${point.x},${point.y}   ${latLng.latitude}/${latLng.longitude}");
        List features = await _mapController!
            .queryRenderedFeatures(point, ["poi-label"], null);

        if (features.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('QueryRenderedFeatures: No features found!')));
        } else if (features.isNotEmpty) {
          setState(() {
            _showSelection = true;
          });
          _onFeatureClick(features[0]);
        }
      },
    );
  }
}
