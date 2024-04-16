import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_gl/mappls_gl.dart';
import 'package:mappls_hackathon/guesser/guesserscreen.dart';
import 'package:mappls_hackathon/guesser/guesserscreen2.dart';
import 'package:mappls_hackathon/guesser/guesserscreen3.dart';
import 'package:mappls_hackathon/home/helpscreen.dart';
import 'package:mappls_hackathon/home/homescreen.dart';
import 'package:flutter/services.dart';
import 'package:mappls_hackathon/home/search.dart';
import 'package:mappls_hackathon/home/searchscreen.dart';
import 'package:mappls_hackathon/loginscreen.dart';
import 'package:mappls_hackathon/nearby/carouselscreen.dart';
import 'package:mappls_hackathon/nearby/nearbyscreen.dart';
import 'package:mappls_hackathon/home/settings_screen.dart';
import 'package:mappls_hackathon/nearby/nearbyscreen2.dart';
import 'package:mappls_hackathon/splashscreen.dart';
import 'package:mappls_hackathon/home/userscreen.dart';
import 'package:mappls_hackathon/trans.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static const String MAP_SDK_KEY = "a259485b-0efa-466d-883c-ada758ec2e0f";
  static const String REST_API_KEY = "542dbb0ec43d4e94a956e1e2cbc7f4ff";
  static const String ATLAS_CLIENT_ID =
      "96dHZVzsAuveQBGTIIFIkYeraMJFqt9L-06b5-IZHvdE8vEECvvcoGE3eUKOIV_oMbjvJVxHi7WFgRpj6mCo8Q==";
  static const String ATLAS_CLIENT_SECRET =
      "lrFxI-iSEg_wXM1SNMY3-6sT4f-sjg_mdhe4x4urdW6rIkLmeQ_09lBxUmGFh8EB-F5HRjtEUZJCEOBzmw5vpwGro5mlEB6d";
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MapplsAccountManager.setMapSDKKey(MAP_SDK_KEY);
    MapplsAccountManager.setRestAPIKey(REST_API_KEY);
    MapplsAccountManager.setAtlasClientId(ATLAS_CLIENT_ID);
    MapplsAccountManager.setAtlasClientSecret(ATLAS_CLIENT_SECRET);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: MyAppRoutes()._router,
    );
  }
}

class MyAppRoutes {
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    errorPageBuilder: (BuildContext context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(
            'Error ${state.error}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: SplashScreen(),
        ),
        // builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: SplashScreen(),
        ),
        // builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: LoginScreen(),
        ),
        // builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: HomeScreen(),
        ),
        // builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/home/nearby',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: NearByScreen(),
        ),
        // builder: (context, state) => NearByScreen(),
      ),
      GoRoute(
        path: '/home/nearby/carousel_display',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: CarouselScreen(),
        ),
        // builder: (context, state) => CarouselScreen(),
      ),
      GoRoute(
        path: '/home/user',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: UserScreen(),
        ),
        // builder: (context, state) => UserScreen(),
      ),
      GoRoute(
        path: '/home/help',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: HelpScreen(),
        ),
      ),
      GoRoute(
        path: '/home/settings',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: SettingsScreen(),
        ),
        // builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: '/home/search',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: SearchScreen(),
        ),
        // builder: (context, state) => SearchScreen(),
      ),
      GoRoute(
        path: '/home/guesser',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: GuesserScreen(),
        ),
        // builder: (context, state) => GuesserScreen(),
      ),
      GoRoute(
        path: '/home/guesser/mapview',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: GuesserScreenMap()),
        // builder: (context, state) => GuesserScreenMap(),
      ),
      GoRoute(
        path: '/home/guesser/card',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: GuesserCard(),
        ),
        // builder: (context, state) => GuesserCard(),
      ),
      GoRoute(
        path: '/home/nearbyy',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: NearByScreen2(),
        ),
        // builder: (context, state) => GuesserCard(),
      ),
       GoRoute(
        path: '/home/trans',
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: transScreen(),
        ),
        // builder: (context, state) => GuesserCard(),
      ),
      
        // builder: (context, state) => SearchScreen(),
     
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
