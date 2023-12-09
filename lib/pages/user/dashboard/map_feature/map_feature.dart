import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:collection/collection.dart';

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
  List<Object>? _featureQueryFilter = [
    "!=",
    ["get", "type"],
    "zoo",
  ];
  Fill? _selectedFill;

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

  void _clearFill() {
    if (_selectedFill != null) {
      _mapController!.removeFill(_selectedFill!);
      setState(() {
        _selectedFill = null;
      });
    }
  }

  void _drawFill(List<dynamic> features) async {
    Map<String, dynamic>? feature = features.firstWhereOrNull((f) {
      return f['geometry']['type'] == 'Polygon';
    });
    if (feature != null) {
      List<List<LatLng>> geometry = feature['geometry']['coordinates']
          .map(
              (ll) => ll.map((l) => LatLng(l[1], l[0])).toList().cast<LatLng>())
          .toList()
          .cast<List<LatLng>>();
      Fill fill = await _mapController!.addFill(FillOptions(
        geometry: geometry,
        fillColor: "#FF0000",
        fillOutlineColor: "#FF0000",
        fillOpacity: 0.6,
      ));
      setState(() {
        _selectedFill = fill;
      });
    }
  }

  void _onFeatureClick(Map<String, dynamic> feature) {
    final [longitude, latitude] = feature['geometry']['coordinates'];
    print(feature);
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: _mapController!.cameraPosition!.zoom,
        ),
      ),
    );
  }

  bool _showSelection = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              child: Align(
                alignment: Alignment.center,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Create a plan and set this as your destination'),
                    ],
                  ),
                ),
              ),
            ),
        ],
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

        _clearFill();
        if (features.isEmpty && _featureQueryFilter != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('QueryRenderedFeatures: No features found!')));
        } else if (features.isNotEmpty) {
          setState(() {
            _showSelection = true;
          });
          _onFeatureClick(features[0]);
          _drawFill(features);
        }
      },
    );
  }
}
