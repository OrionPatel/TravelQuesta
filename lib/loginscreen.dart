import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_hackathon/custom_loader.dart';
import 'package:mappls_hackathon/models/auth_api_model.dart';
import 'package:mappls_hackathon/services/apiservice.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User? _user;

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Trigger the FutureProvider when the screen is added to the context

      ref.watch(executeAuthentication);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(authStateProvider);
    // final mmiAuthState = ref.watch(logicProvider);
    return Scaffold(
        // appBar: AppBar(
        //     backgroundColor: Colors.black,
        //     title: userAsyncValue.when(
        //       data: (user) => user != null
        //           ? Text('')
        //           : const Text(
        //               'Google Sign In',
        //               style: TextStyle(color: Colors.black),
        //             ),
        //       loading: () => const CircularProgressIndicator(),
        //       error: (error, stackTrace) => Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text('Error: $error '),
        //           Text('StackTrace: $stackTrace'),
        //         ],
        //       ),
        //     )
        //     // const Text('Google Sign In', style: TextStyle(color: Colors.white)),
        //     ),
        body: Container(
      color: Colors.black,
      child: Stack(children: [
        FittedBox(
          child: Image.asset('assets/bg1.png'),
          fit: BoxFit.fitWidth,
        ),

        // Center(child: Image.asset('assets/bg1.png', width: MediaQuery.of(context).size.width,)),
        Center(
          child: Container(
            height: 230,
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
            child: userAsyncValue.when(
              data: (user) => user != null
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Image.asset(
                                  'assets/logo_small.png',
                                  scale: 2,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Dive into a world of\nwonder!",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            GestureDetector(
                              onTap: () async {
                                ref.read(scoreProvider.notifier).state.id =
                                    user?.email ?? 'guest';
                                // ref.read(scoreProvider).fetchScore();
                                print(ref.read(scoreProvider).id);
                                ref.read(scoreProvider).fetchScore();

                                //                     ref.read(userTotalScoreProvider.notifier).state =
                                // (await fetchUserScore(user?.email ?? 'guest')) ?? 0;
                                context.go('/home',
                                    extra: 'Data from login screen');
                              },
                              child: SizedBox(
                                height: 55,
                                width: 150,
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "Play",
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
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Image.asset(
                                  'assets/logo_small.png',
                                  scale: 2,
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                "Please choose your login\nmethod",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                            GestureDetector(
                              onTap: () async {
                                ref.read(AuthTokenProvider.notifier).state =
                                    await auth_token_api() ?? '';
                                await _handleGoogleSignIn();

                                ref.read(AuthTokenProvider.notifier).state =
                                    await auth_token_api() ?? '';

                                _auth.authStateChanges().listen((event) {
                                  _user = event;
                                });
                              },
                              child: SizedBox(
                                height: 55,
                                width: 250,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/google_logo.png',
                                        scale: 4,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "Continue with Google",
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xff3A3A3A),
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
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
                        ),
                      ),
                    ),
              loading: () => CustomLoader(),
              error: (error, stackTrace) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $error '),
                  Text('StackTrace: $stackTrace'),
                ],
              ),
            ),
          ),
        ),
      ]),
    ));
  }

  @override
  void dispose() {
    
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(_googleAuthProvider);
    } catch (e) {
      print('Error: $e');
    }
  }
}

class WelcomePage extends ConsumerWidget {
  final User user;
  const WelcomePage({super.key, required this.user});

  void pushReplacement(BuildContext context) {
    context.go('/home', extra: 'Data from login screen');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: ElevatedButton(
            child: Text('Welcome ${user.displayName}, Lets get started'),
            onPressed: () => pushReplacement(context),
          ),
        ),
      ),
    );
  }
}
