import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapFeature extends StatefulWidget {
  const MapFeature({super.key});

  @override
  State<MapFeature> createState() => MapFeatureState();
}

class MapFeatureState extends State<MapFeature> {
  String mapboxAccessToken =
      'pk.eyJ1Ijoiam9pbmVyIiwiYSI6ImNsbWN6eHpkeTE0dGczZG1iOGZlb2drdnUifQ.7R0izGL1KjW64Un0DeC8Gg';
  MapboxMapController? _mapController;
  // String _mapStyle = 'mapbox://styles/joiner/clmemo810014b01r8h9ps0et3';
  String _mapStyle = 'assets/mapbox_style/style.json';
  String? _featureName;
  String? _featureType;
  double _maxZoom = 13;
  double _minZoom = 8;
  OfflineRegionDefinition? _offlineRegion;

  @override
  void initState() {
    super.initState();
    _downloadRegion();
  }

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
  }

  void _onStyleLoadedCallback() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Map loaded"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 1),
    ));
  }

  void _onFeatureClick(Map<String, dynamic> feature) {
    final [longitude, latitude] = feature['geometry']['coordinates'];

    _featureName = feature['properties']['name'];
    _featureType = feature['properties']['type'];
    print(_mapController?.cameraPosition?.zoom);
    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: _mapController!.cameraPosition!.zoom,
        ),
      ),
    );
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 56),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _featureName!,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                _featureType!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Set this as your destination',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.maxFinite,
                child: FilledButton(
                  onPressed: () {
                    context.pushNamed('LobbyCreation',
                        extra: {'destination': _featureName});
                  },
                  child: Text('Create lobby'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _downloadRegion() async {
    LatLngBounds _region7 = LatLngBounds(
      southwest: LatLng(9.281254344751304, 122.97505860213238),
      northeast: LatLng(11.235728708626041, 124.3549413978684),
    );
    _offlineRegion = OfflineRegionDefinition(
      bounds: _region7,
      mapStyleUrl: _mapStyle,
      minZoom: _minZoom,
      maxZoom: _maxZoom,
    );
    // final bounds = _offlineRegion!.bounds;
    // final lat = (bounds.southwest.latitude + bounds.northeast.latitude) / 2;
    // final long = (bounds.southwest.longitude + bounds.northeast.longitude) / 2;
    await downloadOfflineRegion(_offlineRegion!,
        accessToken: mapboxAccessToken);
  }

  Widget mapboxMap() {
    if (_offlineRegion == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return MapboxMap(
      styleString: _mapStyle,
      accessToken: mapboxAccessToken,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoadedCallback,
      initialCameraPosition:
          const CameraPosition(target: LatLng(10.26, 123.665), zoom: 8),
      minMaxZoomPreference: MinMaxZoomPreference(8, 13),
      cameraTargetBounds: CameraTargetBounds(_offlineRegion?.bounds),
      trackCameraPosition: true,
      onMapClick: (point, latLng) async {
        List features = await _mapController!
            .queryRenderedFeatures(point, ["poi-label"], null);
        if (features.isNotEmpty) {
          _onFeatureClick(features[0]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: mapboxMap(),
    );
  }
}
