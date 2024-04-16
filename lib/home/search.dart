import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_hackathon/logic.dart';
import 'package:mappls_hackathon/services/apiservice.dart';
import 'package:provider/provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: FittedBox(
          child: Image.asset('assets/bg1.png'),
          fit: BoxFit.fitWidth,
        ),
      ),

      // Center(child: Image.asset('assets/bg1.png', width: MediaQuery.of(context).size.width,)),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
              height: 270,
              width: 300,
              decoration: const BoxDecoration(
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
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        'assets/logo_small.png',
                        scale: 2,
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Search interesting travel spots\naround a location",
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      // width: 30,
                      height: 50,
                      child: TextField(
                        style: TextStyle(
                            color: Color(0xffFBBC05), fontFamily: 'Montserrat'),
                        onChanged: (value) {
                          ref
                              .read(logicProvider.notifier)
                              .state
                              .searchLocation = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter text',
                          labelText: 'Enter',
                          labelStyle: TextStyle(
                              color: Color(0xffFBBC05),
                              fontFamily: 'Montserrat'),
                          border: OutlineInputBorder(
                              // borderSide: BorderSide(color: Color(0xffFBBC05)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffFBBC05)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  GestureDetector(
                    onTap: () {
                      ref.invalidate(executeSearchButtonLogicProvider);
                      ref.read(executeSearchButtonLogicProvider);
                      // ref.read(cardStateProvider.notifier).state.cardState =
                          // true;
                      context.go('/home/nearbyy');
                    },
                    child: SizedBox(
                      height: 55,
                      width: 150,
                      child: Container(
                        child: Center(
                          child: Text(
                            "Search",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xff3A3A3A),
                                fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          color: Color(0xffF2F2F2),
                        ),
                      ),
                      // child: SignInButton(
                      //   Buttons.google,
                      //   text: 'Sign up with Google',
                      //   onPressed: () async {
                      //     ref.read(AuthTokenProvider.notifier).state =
                      //         await auth_token_api() ?? '';
                      //     await _handleGoogleSignIn();

                      //     ref.read(AuthTokenProvider.notifier).state = await auth_token_api()??'';

                      //     _auth.authStateChanges().listen((event) {
                      //       _user = event;

                      //     });
                      //   },
                      // ),
                    ),
                  ),
                ],
              )),
        ),
      ),
      Positioned(
          top: 30,
          left: 45,
          child: GestureDetector(
            onTap: () {
              context.go('/home');
            },
            child: Image.asset('assets/home_button_yellow.png', scale: 4),
          )),
    ]);
  }
}
