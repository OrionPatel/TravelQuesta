import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_hackathon/custom_loader.dart';
import 'package:mappls_hackathon/home/homescreen.dart';
// import 'package:mappls_hackathon/homescreen.dart';
import 'package:mappls_hackathon/logic.dart';
// import 'package:mappls_hackathon/nearby/customslider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mappls_hackathon/services/apiservice.dart';

class NearByScreen extends ConsumerStatefulWidget {
  NearByScreen({Key? key}) : super(key: key);
  _NearByScreenState createState() => _NearByScreenState();
}

class _NearByScreenState extends ConsumerState<NearByScreen> {
  double _currentSliderValue = 0;
  String _displayedValue = '1';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Trigger the FutureProvider when the screen is added to the context

      ref.watch(executeLocationProvider);
      // ref.watch(executeSearchButtonLogicProvider);

    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(logicProvider);
    final sliderValue = ref.watch(radiusProvider);
    print(sliderValue);
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: state.status == 'loaded'
            ? Stack(children: [
                FittedBox(
                  child: Image.asset('assets/bg1.png'),
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 20,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    height: 250,
                    width: 600,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/logo_smol.png',
                          scale: 4,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Explore the locations near you',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Please specify radius:',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 485,
                              ),
                              Text(
                                '${sliderValue.toInt()}km',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    color: Color(0xffFBBC05)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Slider(
                            activeColor: Color.fromARGB(255, 39, 48, 107),
                            thumbColor: Colors.amber[600],
                            value: _currentSliderValue,
                            max: 200,
                            // min: 0.5,
                            divisions: 40,
                            onChanged: (double value) {
                              print(value);
                              ref.read(radiusProvider.notifier).state = value;
                              _currentSliderValue = value;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // await executeNearbyLogic(ref.read(LatitudeProvider),
                            //     ref.read(LongitudeProvider), ref.read(radiusProvider));
                            // context.go('/home/nearby/carousel_display');
                            // Map<String, dynamic>? map;
                            //   map = await executeGameLogic();
                            //   ref.read(GuesserProvider.notifier).state = map ??
                            //       {
                            //         "name": "India",
                            //         "address": "India",
                            //         "eLoc": "SAC1S3"
                            //       };
                            //   print(ref.read(GuesserProvider));
                            //   Map<String, dynamic> coords = await geocoding_api(
                            //           ref.read(GuesserProvider)['address']) ??
                            //       {"lat": 24.779478, "lng": 77.549033};
                            //   print(coords);
                            //   ref.read(LongitudeProvider.notifier).state =
                            //       coords['lng'] ?? 77.549033;
                            //   ref.read(LatitudeProvider.notifier).state =
                            //       coords['lat'] ?? 24.779478;
                            //   print(ref.read(LongitudeProvider));
                            //   print(ref.read(LatitudeProvider));
                            ref.read(cardStateProvider).changeCardState(true);
                            //  ref.read(cardStateProvider.notifier).state.notifyListeners();
                            ref.invalidate(executeChatGPTProvider);
                            ref.read(executeChatGPTProvider);
                            ref.invalidate(executeNearbyLogicProvider);
                            ref.read(executeNearbyLogicProvider);
                            // final user = ref.watch(authStateProvider).value;
                            // ref.read(userScoreProvider.notifier).state =
                            //     (ref.read(DistanceProvider) / 1000).toInt() >=
                            //             400
                            //         ? 100
                            //         : ((ref.read(DistanceProvider) / 1000)
                            //                     .toInt() >=
                            //                 100
                            //             ? 250
                            //             : ((ref.read(DistanceProvider) / 1000)
                            //                         .toInt() >=
                            //                     11
                            //                 ? 500
                            //                 : 1000));
                            // final newScore = ref.read(userScoreProvider);
                            // // addOrUpdateUserScore(user?.email ?? 'guest', newScore);
                            // print('scores updated');

                            context.go('/home/guesser/card');
                          },
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffFBBC05),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                            ),
                            child: Center(
                              child: Text(
                                'Explore',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ])
            : CustomLoader());
  }

  String updateDisplayedValue() {
    String displayValue = _currentSliderValue.toStringAsFixed(1);

    if (displayValue.endsWith('.0') || displayValue.endsWith('.5')) {
      // If the decimal part is .0 or .5, keep the value as it is
      _displayedValue = displayValue;
    } else {
      // Otherwise, approximate to the closest integer
      _displayedValue = _currentSliderValue.round().toString();
    }
    return _displayedValue;
  }
}
