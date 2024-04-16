import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:mappls_hackathon/custom_loader.dart';
import 'package:mappls_hackathon/home/homescreen.dart';
import 'package:mappls_hackathon/logic.dart';
import 'package:mappls_hackathon/services/apiservice.dart';

late MapplsMapController mapControllerr;

class GuesserCard extends ConsumerStatefulWidget {
  GuesserCard({Key? key}) : super(key: key);
  @override
  _GuesserCardState createState() => _GuesserCardState();
}

class _GuesserCardState extends ConsumerState<GuesserCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cardStateProvider).cardState
          ? ref.watch(executeNearbyLogicProvider)
          : ref.watch(executeCalculateDistanceProvider);
      ref.watch(executeChatGPTProvider);
      ref.watch(logicProvider);
      ref.watch(cardStateProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _state = ref.watch(logicProvider);
    final _cardState = ref.watch(cardStateProvider);

    print("jhdbsgksbskssjksdvskjskjvnsvksjn${_state.status}");
    CameraPosition _kInitialPosition = CameraPosition(
      target: LatLng(ref.read(LatitudeProvider), ref.read(LongitudeProvider)),
      zoom: 11.0,
    );
    return Scaffold(
        backgroundColor: Colors.black,
        body: _state.status == 'loaded'
            ? Stack(
                children: [
                  // FittedBox(
                  //   child: Image.asset('assets/bg1.png'),
                  //   fit: BoxFit.fitWidth,
                  // ),
                  Row(
                    children: [
                      Container(
                        width:
                            (MediaQuery.of(context).size.width - 28) * (2 / 3),
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              // child: Image.asset('assets/taj.jpg',
                              //     height: MediaQuery.of(context).size.height,
                              //     width: 400)
                              child: MapplsMap(
                                initialCameraPosition: _kInitialPosition,
                                onMapCreated: (mapController) {
                                  mapControllerr = mapController;
                                  addMarker();
                                },
                                onStyleLoadedCallback: () {
                                  addMarker();
                                },
                              )),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width:
                            (MediaQuery.of(context).size.width - 28) * (1 / 3),
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: (Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: Text(
                                  '${ref.watch(GuesserProvider).map['name']}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 36,
                                      color: Color(0xffFBBC05)),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Text(
                                  '${ref.watch(GuesserProvider).map['address']}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Color(0xffFFFFFF)),
                                ),
                              ),
                              SizedBox(
                                height: 160,
                                child: ref.watch(chatGPTResponseProvider) == ''
                                    ? Center(
                                        child: SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: Image.asset(
                                              'assets/chatgpt.png',
                                              scale: 4,
                                            )),
                                      )
                                    : Text(
                                        ref.read(chatGPTResponseProvider),
                                        style: TextStyle(
                                            fontFamily: 'Montserrat-reg',
                                            fontSize: 11,
                                            color: Color(0xffCBCBCB)),
                                        // overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                              ),
                              !_cardState.cardState
                                  ? SizedBox(
                                      height: 50,
                                      child: Text(
                                        'Congrats! You scored ${(ref.read(DistanceProvider) / 1000).toInt() >= 400 ? 100 : ((ref.read(DistanceProvider) / 1000).toInt() >= 100 ? 250 : ((ref.read(DistanceProvider) / 1000).toInt() >= 11 ? 500 : 1000))} points.',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            color: Color(0xffFBBC05)),
                                      ),
                                    )
                                  : Container(),
                              !_cardState.cardState
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          // Map<String, dynamic>? map;
                                          // map = await executeGameLogic();
                                          // ref.read(GuesserProvider.notifier).state = map ??
                                          //     {
                                          //       "name": "India",
                                          //       "address": "India",
                                          //       "eLoc": "SAC1S3"
                                          //     };
                                          // print(ref.read(GuesserProvider));
                                          // Map<String, dynamic> coords = await geocoding_api(
                                          //         ref.read(GuesserProvider)['address']) ??
                                          //     {"lat": 24.779478, "lng": 77.549033};
                                          // print(coords);
                                          // ref.read(LongitudeProvider.notifier).state =
                                          //     coords['lng'] ?? 77.549033;
                                          // ref.read(LatitudeProvider.notifier).state =
                                          //     coords['lat'] ?? 24.779478;
                                          // print(ref.read(LongitudeProvider));
                                          // print(ref.read(LatitudeProvider));
                                          ref
                                              .read(cardStateProvider)
                                              .changeCardState(false);

                                          ref
                                              .read(scoreProvider.notifier)
                                              .state
                                              .value = (ref.read(
                                                              DistanceProvider) /
                                                          1000)
                                                      .toInt() >=
                                                  400
                                              ? 100
                                              : ((ref.read(DistanceProvider) /
                                                              1000)
                                                          .toInt() >=
                                                      100
                                                  ? 250
                                                  : ((ref.read(DistanceProvider) /
                                                                  1000)
                                                              .toInt() >=
                                                          11
                                                      ? 500
                                                      : 1000));
                                          ref.read(scoreProvider).field = ref
                                              .read(GuesserProvider)
                                              .map["cat"];
                                          ref
                                              .read(scoreProvider)
                                              .addUpdateScores();
                                          print(ref.read(scoreProvider).map);
                                          ref.read(scoreProvider).personalise(
                                              ref
                                                  .read(logicProvider.notifier)
                                                  .state);
                                          ref.refresh(executeGameLogicProvider);
                                          context.go('/home/guesser');
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Color(0xffFBBC05),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(50),
                                                  topRight: Radius.circular(50),
                                                  bottomLeft:
                                                      Radius.circular(50),
                                                  bottomRight:
                                                      Radius.circular(50)),
                                            ),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat'),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Image.asset(
                                                  'assets/arrow.png',
                                                  scale: 4,
                                                ),
                                              ],
                                            ))
                                            // child: MaterialButton(
                                            //   color: Color(0xffFBBC05),
                                            //   onPressed: () {
                                            //     context.go('/home/guesser/mapview');
                                            //   },
                                            //   child: Text(
                                            //     "Submit",
                                            //     style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),
                                            //   ),

                                            // ),
                                            ),
                                      ),
                                    )
                                  : Container(),
                              !_cardState.cardState
                                  ? Container()
                                  : SizedBox(
                                      height: 80,
                                      child: Text(
                                        'Use arrow keys on the map to browse through various POIs.',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 16,
                                            color: Color(0xffFBBC05)),
                                      ),
                                    )
                            ],
                          )),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      top: 30,
                      left: 45,
                      child: GestureDetector(
                        onTap: () {
                          context.go('/home');
                        },
                        child: Image.asset('assets/home_button.png', scale: 4),
                      )),
                  _cardState.cardState
                      ? Positioned(
                          top: (MediaQuery.of(context).size.height / 2) - 20,
                          left: 45,
                          child: GestureDetector(
                            onTap: () {
                              // print(ref.read(cardStateProvider).map);
                              ref.read(cardStateProvider).populateMap();
                              ref
                                      .read(GuesserProvider.notifier)
                                      .state
                                      .map['name'] =
                                  ref
                                      .read(cardStateProvider.notifier)
                                      .state
                                      .map['name'];
                              ref
                                      .read(GuesserProvider.notifier)
                                      .state
                                      .map['address'] =
                                  ref
                                      .read(cardStateProvider.notifier)
                                      .state
                                      .map['adress'];
                              ref
                                      .read(GuesserProvider.notifier)
                                      .state
                                      .map['eLoc'] =
                                  ref
                                      .read(cardStateProvider.notifier)
                                      .state
                                      .map['eLoc'];
                              ref.invalidate(executeChatGPTProvider);
                              context.go("/home/trans");
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(right: 3),
                                  child:
                                      Image.asset('assets/left.png', scale: 6)),
                            ),
                          ))
                      : Container(),
                  _cardState.cardState
                      ? Positioned(
                          top: (MediaQuery.of(context).size.height / 2) - 15,
                          right: (MediaQuery.of(context).size.width / 3) + 65,
                          child: GestureDetector(
                            onTap: () {
                              ref.read(cardStateProvider).populateMap();
                              ref
                                      .read(GuesserProvider.notifier)
                                      .state
                                      .map['name'] =
                                  ref
                                      .read(cardStateProvider.notifier)
                                      .state
                                      .map['name'];
                              ref
                                      .read(GuesserProvider.notifier)
                                      .state
                                      .map['address'] =
                                  ref
                                      .read(cardStateProvider.notifier)
                                      .state
                                      .map['adress'];
                              ref
                                      .read(GuesserProvider.notifier)
                                      .state
                                      .map['eLoc'] =
                                  ref
                                      .read(cardStateProvider.notifier)
                                      .state
                                      .map['eLoc'];
                              ref.invalidate(executeChatGPTProvider);
                              context.go("/home/trans");
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Image.asset('assets/right.png',
                                      scale: 6)),
                            ),
                          ))
                      : Container()
                ],
              )
            : CustomLoader());
  }

  @override
  void dispose() {
    print("DISPOSEKCHBDKVCJBDFVKJ");
    super.dispose();
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapControllerr.addImage(name, list);
  }

  void addMarker() async {
    await addImageFromAsset("icon", "assets/symbols/custom-icon.png");
    mapControllerr.addSymbol(SymbolOptions(
        geometry:
            LatLng(ref.read(LatitudeProvider), ref.read(LongitudeProvider)),
        iconImage: "icon"));
  }
}
