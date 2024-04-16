import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_hackathon/controllers/text_search_controller.dart';
import 'package:mappls_hackathon/repo/text_search_repo.dart';
import 'package:mappls_hackathon/services/apiservice.dart';
import 'package:mappls_hackathon/home/userscreen.dart';



import '../logic.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomeScreen extends ConsumerWidget {
  // final User user;

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textSearchAsync = ref.watch(textSearchControllerProvider);

    double latitude;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              child: Image.asset('assets/bg1.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo_big.png',
                    scale: 4,
                  ),
                  Text(
                    "\"Explore the world one click at a time.\"",
                    style: TextStyle(
                        fontFamily: 'Beth Ellan',
                        color: Color(0xffFBBC05),
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )),
          ),
          Positioned(
            top: ((MediaQuery.of(context).size.height) / 2),
            right: ((MediaQuery.of(context).size.width) / 2) - 300,
            child: SizedBox(
              height: 100,
              width: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      ref.refresh(executeGameLogicProvider);
                      context.go('/home/guesser');
                    },
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(children: [
                          Image.asset(
                            'assets/button.png',
                            scale: 4,
                          ),
                          Center(
                            child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Image.asset(
                                        'assets/globe.png',
                                        scale: 4,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Guess the location",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xffFBBC05),
                                            fontSize: 13.5),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                
                          ),
                        ]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {

                      ref.invalidate(executeLocationProvider);
                      ref.read(executeLocationProvider);
                      context.go('/home/nearby');
                    },
                    child: Container(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Stack(children: [
                          Image.asset(
                            'assets/button.png',
                            scale: 4,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 7,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image.asset(
                                  'assets/pin.png',
                                  scale: 4,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Explore near me",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xffFBBC05),
                                      fontSize: 13.5),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   child: Container(
                  //     width: 150, // Set desired width
                  //     height: 80,
                  //     child: Card(
                  //       color: Color.fromARGB(255, 75, 75, 75),
                  //       child: Center(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             Icon(
                  //               CupertinoIcons.globe,
                  //               color: Colors.amber,
                  //             ),
                  //             Text(
                  //               'Guesser',
                  //               style: TextStyle(
                  //                   color: Colors.amber[600], fontSize: 20),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   onTap: ,
                  // ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     await _getCurrentLocation().then((value) {
                  //       ref.read(LongitudeProvider.notifier).state =
                  //           value.longitude;
                  //       ref.read(LatitudeProvider.notifier).state =
                  //           value.latitude;
                  //     });
                  //     print('${longitudeProvider}');
                  //     print('${latitudeProvider}');
                  //     print('${ref.read(radiusProvider)}');
                  //     print('${ref.read(AuthTokenProvider)}');
                  //     context.go('/home/nearby');
                  //   },
                  //   child: Container(
                  //     width: 150, // Set desired width
                  //     height: 80,
                  //     child: Card(
                  //       color: Color.fromARGB(255, 75, 75, 75),
                  //       child: Center(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             Icon(
                  //               Icons.location_on,
                  //               color: Colors.amber,
                  //             ),
                  //             Text(
                  //               'NearME',
                  //               style: TextStyle(
                  //                   color: Colors.amber[600], fontSize: 20),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: GestureDetector(
              onTap: () {
                // ref.read(userTotalScoreProvider.notifier).state =
                //     (await fetchUserScore(user?.email ?? 'guest')) ?? 0;
                context.go('/home/user');
              },
              child: Image.asset(
                'assets/menu_button.png',
                scale: 4,
              ),
            ),
          ),
          //   child: IconButton(
          //     iconSize: 50,
          //     color: Colors.amber,
          //     icon: const Icon(Icons.person_pin_circle_outlined),
          //     onPressed: () {
          //       context.go('/home/user');
          //     },
          //   ),
          // ),
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: IconButton(
          //     iconSize: 50,
          //     color: Colors.amber,
          //     icon: const Icon(Icons.settings),
          //     onPressed: () {
          //       context.go('/home/settings');
          //     },
          //   ),
          // ),
          Positioned(
              top: 40,
              right: 90,
              child: GestureDetector(
                onTap: () => context.go('/home/search'),
                child: Image.asset(
                  'assets/search_button.png',
                  scale: 4,
                ),
              )),
              Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => GoRouter.of(context).go('/home/help'),
              child: Icon(
                Icons.help,
                color: Colors.amber.withOpacity(0.8),
                size: 30,
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromARGB(255, 193, 146, 6),
      //   child: const Icon(
      //     Icons.arrow_back,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     // _auth.signOut();
      //     context.go('/login');
      //   },
      // ),
      backgroundColor: Colors.black,
    );
  }
}

final LatitudeProvider = StateProvider<double>(
    (ref) => 24.779478); // Change int to the type of your variable
final LongitudeProvider = StateProvider<double>((ref) => 77.549033);
final RadiusProvider = StateProvider<int>((ref) => 500);
