// ignore_for_file: sort_child_properties_last

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:mappls_hackathon/home/homescreen.dart';
import 'package:mappls_hackathon/logic.dart';

class GuesserScreenMap extends ConsumerStatefulWidget {
  GuesserScreenMap({Key? key}) : super(key: key);

  @override
  _GuesserScreenMapState createState() => _GuesserScreenMapState();
}

class _GuesserScreenMapState extends ConsumerState<GuesserScreenMap> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(24.779478, 77.549033),
    zoom: 3.0,
  );
  LatLng bruh = new LatLng(0.0, 0.0);
  late MapplsMapController mapController;

  static const String REST_API_KEY = "fa8e6897f3e0a523a6562f248dfe4208";
  static const String ATLAS_CLIENT_ID =
      "96dHZVzsAutUS6SzMai1FcOGd7iKEpc2ffbGz9Nhd9iUFld9eXC1jLluDxwwEU5QwBBuQ2R8dAxGlNZ2Ut0MPuxZgQW5q5ni";
  static const String ATLAS_CLIENT_SECRET =
      "lrFxI-iSEg_HPOwMuCs0F_6X49v8WscvtVS_gNl_xcUhxDlWuAhGUk_FJpbxT6MJh7_BMAEo0oXsvPynQqXlDVptGhwduhr_gowauMj4gns=";

  void setPermission() async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.granted) {
        await location.requestPermission();
      }
    }
  }

  @override
  void initState() {
    MapplsAccountManager.setMapSDKKey(ref.read(accessTokenProvider));
    MapplsAccountManager.setRestAPIKey(REST_API_KEY);
    MapplsAccountManager.setAtlasClientId(ATLAS_CLIENT_ID);
    MapplsAccountManager.setAtlasClientSecret(ATLAS_CLIENT_SECRET);

    setPermission();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        context.go('/home');
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: const Color.fromARGB(255, 193, 146, 6),
        //   child: const Icon(Icons.arrow_back, color: Colors.white),
        //   onPressed: () {
        //     context.go('/home');
        //   },
        // ),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Container(
                child: MapplsMap(
                  initialCameraPosition: _kInitialPosition,
                  onMapCreated: (mapController) {
                    this.mapController = mapController;
                  },
                  onMapClick: (point, coordinates) {
                    addMarker(coordinates.longitude, coordinates.latitude);
                    ref.read(GuessLatitudeProvider.notifier).state =
                        coordinates.latitude;
                    ref.read(GuessLongitudeProvider.notifier).state =
                        coordinates.longitude;
                  },
                  onStyleLoadedCallback: () {
                    // addMarker();
                  },
                ),
                color: Colors.grey[850],
              ),
              // Positioned(
              //   top: 10,
              //   right: 10,
              //   child: MaterialButton(
              //     color: Colors.amber,
              //     onPressed: () {
              //       context.go('/home/nearby/carousel_display');
              //     },
              //     child: Text(
              //       'Submit',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              Positioned(
                  top: 30,
                  left: 45,
                  child: GestureDetector(
                    onTap: () {
                      context.go('/home');
                    },
                    child: Image.asset('assets/home_button.png', scale: 4),
                  )),
              Positioned(
                  bottom: 30,
                  right: 45,
                  child: GestureDetector(
                    onTap: () {
                      ref.read(logicProvider.notifier).state.lat1 =
                          ref.read(LatitudeProvider);
                      ref.read(logicProvider.notifier).state.long1 =
                          ref.read(LongitudeProvider);
                      ref.read(logicProvider.notifier).state.lat2 =
                          ref.read(GuessLatitudeProvider);
                      ref.read(logicProvider.notifier).state.long2 =
                          ref.read(GuessLongitudeProvider);
                      ref.invalidate(executeChatGPTProvider);
                      // ref.read(executeChatGPTProvider);

                      // ref.read(DistanceProvider.notifier).state = dist ?? 0.0;
                      ref.read(cardStateProvider).changeCardState(false);
                      // ref.read(logicProvider).setLoading();
                      // ref.refresh(executeGameLogicProvider);
                      ref.invalidate(executeCalculateDistanceProvider);
                      ref.read(executeCalculateDistanceProvider);
                      // ref.read(executeLocationProvider);
                      Future.delayed(const Duration(milliseconds: 1500),
                          () => context.go('/home/guesser/card'));
                    },
                    child:
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Center(child: Image.asset('assets/tick.png', scale: 4))),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  void addMarker(double longitude, double latitude) async {
    await addImageFromAsset("icon", "assets/symbols/custom-icon.png");
    mapController.addSymbol(SymbolOptions(
        geometry: LatLng(latitude, longitude), iconImage: "icon"));
  }
}
