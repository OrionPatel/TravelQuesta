// import 'dart:js';
// import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../logic.dart';

class HelpScreen extends ConsumerWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset(
              'assets/bg1.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: MaterialStateProperty.all<Color>(
                        Colors.amber), // Customize thumb color
                    trackColor: MaterialStateProperty.all<Color>(
                        Colors.grey), // Customize track color
                  ),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Icon(
                              Icons.help_center_outlined,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'How to use TravelQuesta',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.play_arrow_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Guess the Location',
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 250,
                          child: Row(
                            children: [
                              Image.asset('assets/guess_the_location.jpg'),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  '• Use Your Deductive and Image Recognition skills to figure out the Location of the showed Street \n\n\n• When decided click on the Submit button to Submit your guess',
                                  softWrap: true,
                                  style: TextStyle(color: Colors.grey[350]),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: Row(
                            children: [
                              Image.asset('assets/guesser_map_view.png'),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 250,
                                child: Text(
                                  '• Navigate on the Map to your guess and place Your marker! ',
                                  softWrap: true,
                                  style: TextStyle(color: Colors.grey[350]),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.play_arrow_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Explore Near Me',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                            height: 250,
                            child: Row(
                              children: [
                                Image.asset('assets/nearby_screen.png'),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    '• Set the Radius of the Area you would like to Explore around You ',
                                    softWrap: true,
                                    style: TextStyle(color: Colors.grey[350]),
                                  ),
                                ),
                              ],
                            )),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(30.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: const Color.fromARGB(255, 255, 22, 22).withOpacity(0.6),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: SingleChildScrollView(
          //      child: Column(
          //       children: [

          //       ],
          //      ),
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: const Color.fromARGB(175, 255, 193, 7),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          context.go('/home');
        },
      ),
    );
  }
}
