import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_street_view/flutter_google_street_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mappls_hackathon/home/homescreen.dart';
// import 'package:mappls_hackathon/homescreen.dart';
import 'package:mappls_hackathon/services/apiservice.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
final GuessLatitudeProvider = StateProvider<double>(
    (ref) => 24.779478); // Change int to the type of your variable
final GuessLongitudeProvider = StateProvider<double>((ref) => 77.549033);
final DistanceProvider = StateProvider<double>((ref) => 0.0);
final radiusProvider = StateProvider<double>((ref) => 1);
final accessTokenProvider = StateProvider<String>((ref) => '');

class Guesser extends ChangeNotifier {
  Guesser({required this.map});
  Map<String, dynamic> map = {"name": "", "address": "", "eLoc": "", "cat": ""};
  void modifyMap(Map<String, dynamic> newMap) {
    map = newMap;
    notifyListeners();
  }
}

final GuesserProvider = StateProvider<Guesser>((ref) =>
    Guesser(map: {"name": "India", "address": "India", "eLoc": "SAC1S3"}));

// final GuesserProvider = StateProvider<Map<String, dynamic>>(
//     (ref) => {"name": "India", "address": "India", "eLoc": "SAC1S3"});
final AuthTokenProvider = StateProvider<String>((ref) => '');
final chatGPTResponseProvider = StateProvider<String>((ref) => '');

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
final userScoreProvider = StateProvider<int>((ref) => 0);
final userTotalScoreProvider = StateProvider<int>((ref) => 0);
// class datastate extends StateNotifier<logic> {
//   datastate()
//       : super(logic(
//             lat: 24.779478,
//             long: 77.549033,
//             radius: 500,
//             lat1: 24.779478,
//             long1: 77.549033,
//             long2: 77.549033,
//             lat2: 24.779478,
//             status: 'loaded'));
// }

class logic extends ChangeNotifier {
  logic(
      {required this.lat,
      required this.long,
      required this.radius,
      required this.lat1,
      required this.long1,
      required this.long2,
      required this.lat2,
      required this.status,
      required this.searchLocation,
      required this.personalise,
      required this.personalisedList});
  double lat;
  double long;
  double radius;
  double lat1;
  double long1;
  double lat2;
  double long2;
  String status;
  String searchLocation = '';
  bool personalise;
  List<String> personalisedList;
  List<String> pointsOfInterest = [
    "NTCBCH",
    "NTCLAK",
    "NTCWLS",
    "NTCFAL",
    "NTCHLS",
    "NTCISL",
    "NTCNPK",
    "PLPHIN",
    "PLPCHU",
    "HISFRT",
    "HISMUS",
    "HISMON",
    "PREHRG",
    "NOPHRG",
    "FODCON",
    "FODIND",
    "FODCOF",
    "FODNGT",
    "FODPUB",
    "RCNART",
    "RCNCLB",
    "RCNPCB",
    "RCNTHT",
    "RCNAUS",
    "RCNCMP",
    "RCNCSN",
    "RCNGHT",
    "EVTDAN",
    "EVTFOD",
    "EVTCMD",
    "EVTMUS",
    "EVTTHT"
  ];
  List<String> touristPlacesInIndia = [
    // "Colva Beach"
    'Amer Fort',
    // "Taj Mahal",
    "Cafe Grub Up",
    // "Gateway Of India",

    // "BITS Pilani"
    //     // "Qutub Minar",
    //     "Gateway of India",
    // // "India Gate",
    // "Hawa Mahal",
    // "Amer Fort",

    // "Goa Beaches",
    // "Kerala Backwaters",
    // "Golden Temple",
    // "Mysore Palace",
    // "Ellora Caves",
    // "Hampi",
    // "Ranthambore National Park",
    // "Kashmir Valley",
    // "Rishikesh",
    // "Khajuraho Temples",
    // "Darjeeling",
    // "Ajanta Caves",
    // "Sundarbans National Park",
    // "Gir National Park",
    // "Mahabodhi Temple",
    // "Andaman and Nicobar Islands",
    // "Qutub Minar",
    // "Jaisalmer",
    // "Kanyakumari",
    // "Sanchi Stupa",
    // "Meenakshi Temple",
    // "Gateway of India",
    // "Jodhpur",
    // "Amritsar",
    // "Udaipur",
    // "Delhi",
    // "Shimla",
    // "Leh-Ladakh",
    // "Pune",
    // "Nainital",
    // "Kolkata",
    // "Mumbai",
    // "Chennai",
    // "Hyderabad",
    // "Bangalore",
    // "Agra",
    // "Lucknow",
    // "Bodh Gaya",
    // "Puri",
    // "Tirupati",
    // "Haridwar",
    // "Madurai",
    // "Kochi",
    // "Pondicherry",
    // "Ooty",
    // "Manali",
    // "Rajkot",
    // "Ahmedabad",
    // "Surat",
    // "Vadodara",
    // "Nashik",
    // "Allahabad",
    // "Patna",
    // "Ranchi",
    // "Gangtok",
    // "Bhopal",
    // "Indore",
    // "Nagpur",
    // "Chandigarh",
    // "Ludhiana",
    // "Kanpur",
    // "Ghaziabad",
    // "Aurangabad",
    // "Visakhapatnam",
    // "Thiruvananthapuram",
    // "Jammu",
    // "Raipur",
    // "Dehradun",
    // "Gwalior",
    // "Jaipur",
    // "Jabalpur",
    // "Itanagar",
    // "Imphal",
    // "Shillong",
    // "Kohima",
    // "Aizawl",
    // "Panaji",
    // "Agartala",
    // "Gangtok",
    // "Shimla",
    // "Kohima",
    // "Itanagar",
    // "Raipur",
    // "Gandhinagar",
    // "Nagpur",
    // "Amaravati",
    // "Srinagar",
    // "Mumbai",
    // "Thiruvananthapuram",
    // "Bangalore",
    // "Chennai",
    // "Hyderabad",
    // "Dispur",
    // "Patna",
    // "Shimla",
    // "Lucknow",
    // "Kolkata",
    // "Bhopal",
    // "Mumbai",
    // "Jaipur",
    // "Agartala",
    // "Dehradun",
    // "Ranchi",
    // "Bhubaneswar",
    // "Chandigarh",
    // "Panaji",
    // "Gangtok",
  ];
  void setLoading() {
    status = 'loading';
    notifyListeners();
  }

  void setLoaded() {
    status = 'loaded';
    notifyListeners();
  }

  Future<Map<String, dynamic>?> executeGameLogic(String token) async {
    int randomIndex = Random().nextInt(touristPlacesInIndia.length);
    String poi = touristPlacesInIndia[randomIndex];
    status = 'loading';
    notifyListeners();
    Map<String, dynamic>? map = await text_search_api(poi, token);
    if (map != null) {
      Map<String, dynamic> relevantData = {
        "name": map['placeName'],
        "address": map['placeAddress'],
        "eLoc": map['eLoc'],
        "cat": map['keywords'][0]
      };
      status = 'loaded';
      notifyListeners();
      print(relevantData);
      return relevantData;
    }
  }

  Future<List<dynamic>> executeNearbyLogic(String token) async {
    int randomIndex = Random().nextInt(pointsOfInterest.length - 1);
    // String poi =  pointsOfInterest[randomIndex];
    String poi =
        personalise ? personalisedList.join(';') : pointsOfInterest.join(';');
    // print(poi);
    // status = 'loading';
    // notifyListeners();
    status = 'loading';
    notifyListeners();
    List<dynamic> map = await nearby_api(
      poi,
      lat,
      long,
      radius,
      token,
    );

    status = 'loaded';

    notifyListeners();
    print(map);
    return map;
  }

  Future<double?> calculateDistance(String token) async {
    print('this api running bitch');
    status = 'loading';
    notifyListeners();
    double dist = await distance_matrix_api(lat1, long1, lat2, long2) ?? 0;
    status = 'loaded';
    notifyListeners();
    print(dist);
    return dist;
  }

  Future<String> fetchAccessToken() async {
    status = 'loading';
    notifyListeners();
    String token = await auth_token_api();

    status = 'loaded';
    notifyListeners();
    return token;
  }

  Future<String> fetchChatGPTResponse(String query) async {
    // status = 'loading';
    // notifyListeners();
    String response = await chat_gpt_api(query);
    return response;
  }

  Future<String> fetchLocationCoords(String query) async {
    // status = 'loading';
    notifyListeners();
    String response = await chat_gpt_api(query);
    return response;
  }

  Future<String> fetchSearchCoords(String query) async {
    // status = 'loading';
    notifyListeners();
    String response = await chat_gpt_api(query);
    return response;
  }
}

final logicProvider = StateProvider<logic>((ref) => logic(
    lat: 24.779478,
    long: 77.549033,
    radius: 500,
    lat1: 24.779478,
    long1: 77.549033,
    long2: 77.549033,
    lat2: 24.779478,
    status: 'loaded',
    searchLocation: '',
    personalise: false,
    personalisedList: []));

final executeSearchButtonLogicProvider = FutureProvider<void>((ref) async {
  // ref.read(logicProvider).setLoading();
  Map<String, dynamic> coords =
      await geocoding_api(ref.read(logicProvider).searchLocation) ??
          {"lat": 24.779478, "lng": 77.549033};
  ref.read(LongitudeProvider.notifier).state = coords['lng'] ?? 77.549033;
  ref.read(LatitudeProvider.notifier).state = coords['lat'] ?? 24.779478;
  ref.read(logicProvider.notifier).state.lat = coords['lat'] ?? 24.779478;
  ref.read(logicProvider.notifier).state.long = coords['lng'] ?? 77.549033;
  // ref.read(logicProvider).setLoaded();
});

final executeGameLogicProvider = FutureProvider<void>((ref) async {
  print('provider being refresheddfgbdfskjndsgjkdfnsgbkjdfsngvb');

  Map<String, dynamic>? map;
  // ref.read(logicProvider.notifier).state.status = 'loading';

  map = await ref
      .watch(logicProvider)
      .executeGameLogic(ref.read(accessTokenProvider));
  ref.read(GuesserProvider).modifyMap(map ??
      {"name": "India", "address": "India", "eLoc": "SAC1S3", "cat": ""});

  print(ref.read(GuesserProvider));
  Map<String, dynamic> coords = await geocoding_api(
          "${ref.read(GuesserProvider).map['name']}, ${ref.read(GuesserProvider).map['address']}") ??
      {"lat": 24.779478, "lng": 77.549033};
  print(coords);
  ref.read(LongitudeProvider.notifier).state = coords['lng'] ?? 77.549033;
  ref.read(LatitudeProvider.notifier).state = coords['lat'] ?? 24.779478;
  print(ref.read(LongitudeProvider));
  print(ref.read(LatitudeProvider));

  // ref.read(scoreProvider.notifier).state.value =
  //     (ref.read(DistanceProvider) / 1000).toInt() >= 400
  //         ? 100
  //         : ((ref.read(DistanceProvider) / 1000).toInt() >= 100
  //             ? 250
  //             : ((ref.read(DistanceProvider) / 1000).toInt() >= 11
  //                 ? 500
  //                 : 1000));
  // ref.read(scoreProvider).field = ref.read(GuesserProvider).map["cat"];
  // await ref.read(scoreProvider).addUpdateScores();
  // print(ref.read(scoreProvider).map);
  // ref.read(logicProvider.notifier).state.status = 'loaded';

  // return ref.watch(logicProvider).executeGameLogic();
});
final executeNearbyButtonProvider = FutureProvider<void>((ref) async {
  ref.read(logicProvider).setLoading();
  ref.read(cardStateProvider).populateMap();
  ref.read(GuesserProvider).modifyMap(ref.watch(cardStateProvider).map);

  Map<String, dynamic> coords =
      await geocoding_api(ref.read(GuesserProvider).map['address']) ??
          {"lat": 24.779478, "lng": 77.549033};
  print(coords);
  ref.read(logicProvider).setLoaded();
  ref.read(LongitudeProvider.notifier).state = coords['lng'] ?? 77.549033;
  ref.read(LatitudeProvider.notifier).state = coords['lat'] ?? 24.779478;
});

final executeLocationProvider = FutureProvider<void>((ref) async {
  Position? _currentLocation;
  final longitudeProvider = ref.watch(LongitudeProvider);
  final latitudeProvider = ref.watch(LatitudeProvider);
  late bool servicePermission = false;
  late LocationPermission permission;
  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied perm');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  ref.read(logicProvider.notifier).state.status = 'loading';
  ref.read(logicProvider.notifier).state.notifyListeners();
  await _getCurrentLocation().then((value) {
    ref.read(LongitudeProvider.notifier).state = value.longitude;
    ref.read(LatitudeProvider.notifier).state = value.latitude;
  });
  print('${longitudeProvider}');
  print('${latitudeProvider}');
  print('${ref.read(radiusProvider)}');
  print('${ref.read(AuthTokenProvider)}');
  ref.read(radiusProvider.notifier).state = 1;
  ref.read(logicProvider.notifier).state.status = 'loaded';
  ref.read(logicProvider.notifier).state.notifyListeners();
});

final executeNearbyLogicProvider = FutureProvider<void>((ref) async {
  ref.read(logicProvider.notifier).state.lat = ref.read(LatitudeProvider);
  ref.read(logicProvider.notifier).state.long = ref.read(LongitudeProvider);
  ref.read(logicProvider.notifier).state.radius = ref.read(radiusProvider);
  List<dynamic> list;
  // ref.read(logicProvider.notifier).state.status = 'loading';
  list = await ref
      .read(logicProvider)
      .executeNearbyLogic(ref.read(accessTokenProvider));
  ref.read(cardStateProvider.notifier).state.list = list;
  ref.read(cardStateProvider.notifier).state.populateMap();

  ref.read(GuesserProvider.notifier).state.map['name'] =
      ref.watch(cardStateProvider).map['name'];
  ref.read(GuesserProvider.notifier).state.map['address'] =
      ref.watch(cardStateProvider).map['address'];
  ref.read(GuesserProvider.notifier).state.map['eLoc'] =
      ref.watch(cardStateProvider).map['eLoc'];

  // ref.read(logicProvider.notifier).state.status = 'loaded';
  // ref.read(logicProvider.notifier).state.notifyListeners();
});

final executeAuthentication = FutureProvider<void>((ref) async {
  ref.read(accessTokenProvider.notifier).state =
      await ref.watch(logicProvider).fetchAccessToken();
  // ref.watch(logicProvider).status = 'loaded';
  // ref.watch(logicProvider).notifyListeners();
  // print(ref.read(accessTokenProvider));
});

final executeCalculateDistanceProvider = FutureProvider<void>((ref) async {
  ref.read(DistanceProvider.notifier).state = await ref
          .read(logicProvider)
          .calculateDistance(ref.read(AuthTokenProvider)) ??
      0;
});

final executeChatGPTProvider = FutureProvider<void>((ref) async {
  ref.read(chatGPTResponseProvider.notifier).state = '';
  ref.read(chatGPTResponseProvider.notifier).state = await ref
      .watch(logicProvider)
      .fetchChatGPTResponse(ref.read(GuesserProvider).map['name']);
  // ref.read(logicProvider.notifier).state.status = 'loaded';
  // ref.read(logicProvider).notifyListeners();
});

class nearbyCardState extends ChangeNotifier {
  nearbyCardState(
      {required this.cardState,
      required this.index,
      required this.list,
      required this.map});
  bool cardState;
  int index;
  List<dynamic> list;
  Map<String, dynamic> map = {'name': "", 'address': "", 'eLoc': ""};

  void changeCardState(bool value) {
    this.cardState = value;
    notifyListeners(); // Notify listeners of the change
  }

  void changeIndex(int value) {
    this.index = value;
    notifyListeners();
  }

  void populateMap() {
    int randomIndex = Random().nextInt(list.length);
    this.index = randomIndex;
    changeIndex(randomIndex);
    this.map['name'] = list[index]['placeName'];
    this.map['address'] = list[index]['placeAddress'];
    this.map['eLoc'] = list[index]['eLoc'];
    notifyListeners();
  }
}

final cardStateProvider = StateProvider<nearbyCardState>(
    (ref) => nearbyCardState(cardState: false, index: 0, list: [], map: {}));

class lState extends ChangeNotifier {
  bool _llState = true;
  bool get llState => _llState;

  void setLoading() {
    _llState = false;
    notifyListeners(); // Notify listeners of the change
  }

  void setLoaded() {
    _llState = true;
    notifyListeners();
  }
}

final stateProvider = ChangeNotifierProvider<lState>((ref) => lState());

class ScoreHandler {
  ScoreHandler({required this.id, required this.field, required this.value});
  String id;
  String field;
  int value;
  Map<String, dynamic> map =
      Map.fromIterable(elocs, key: (item) => item, value: (item) => 0);

  Future<void> addUpdateScores() async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('userScores').doc(id);
      final userDoc = await userRef.get();
      print(userDoc.data());

      if (userDoc.exists) {
        final userData = userDoc.data();
        // Map<String, dynamic> scores = {};

        // if (userData != null && userData.containsKey('scores')) {
        //   // scores = Map<String, dynamic>.from(userData['scores']);
        // }
        map = userData?['scores'];
        int cur = map[field];
        cur += value;
        map[field] = cur;
        cur = map['total'];
        cur += value;
        map['total'] = cur;

        await userRef.set({'scores': map});
      } else {
        Map<String, dynamic> map =
            Map.fromIterable(elocs, key: (item) => item, value: (item) => 0);
        await userRef.set({'scores': map});
      }
    } catch (e) {
      print('Error adding or updating user Score: $e');
    }
  }

  Future<void> fetchScore() async {
    try {
      final userRef =
          FirebaseFirestore.instance.collection('userScores').doc(id);
      final userDoc = await userRef.get();
      Map<String, dynamic> map =
          Map.fromIterable(elocs, key: (item) => item, value: (item) => 0);

      if (userDoc.exists) {
        final userData = userDoc.data();
        final scoresData = userData?['scores']; // Access 'scores' field

        if (scoresData != null) {
          this.map = scoresData;
          // return scoresData;
        } else {
          // If the field doesn't exist, create it and set its value to 0

          await userRef.update({'scores': map});
          // this.map = map;
        }
      } else {
        // Create new document with initial score if it doesn't exist
        await userRef.set({'scores': map});
        // this.map = map;
      }
    } catch (e) {
      print('Error: $e');
      Map<String, dynamic> map =
          Map.fromIterable(elocs, key: (item) => item, value: (item) => 0);
      this.map = map;
    }
  }

  void personalise(logic Logic) {
    if (map['total'] >= 10000) {
      List<String> add = [];
      Logic.personalise = true;
      map.forEach((k, v) {
        if (k == 'total')
          ;
        else if (v >= (.1 * map['total'])) {
          add.add(k);
        }
      }
      );
      Logic.personalisedList=add;
    } else {
      Logic.personalise = false;
    }
  }
}

final scoreProvider = StateProvider<ScoreHandler>(
    (ref) => ScoreHandler(id: '', field: '', value: 0));

List elocs = [
  "total",
  "NTCBCH",
  "NTCLAK",
  "NTCWLS",
  "NTCFAL",
  "NTCHLS",
  "NTCISL",
  "NTCNPK",
  "PLPHIN",
  "PLPCHU",
  "HISFRT",
  "HISMUS",
  "HISMON",
  "PREHRG",
  "NOPHRG",
  "FODCON",
  "FODIND",
  "FODCOF",
  "FODNGT",
  "FODPUB",
  "RCNART",
  "RCNCLB",
  "RCNPCB",
  "RCNTHT",
  "RCNAUS",
  "RCNCMP",
  "RCNCSN",
  "RCNGHT",
  "EVTDAN",
  "EVTFOD",
  "EVTCMD",
  "EVTMUS",
  "EVTTHT"
];


// Future<void> addOrUpdateUserScore(String userId, int newScore, ) async {
//   try {
//     final userRef =
//         FirebaseFirestore.instance.collection('userData').doc(userId);
//     final userDoc = await userRef.get();

//     if (userDoc.exists) {
//       // If the document exists, update the score
//       final currentScore = userDoc.data()?['score'] ?? 0;
//       final updatedScore = currentScore + newScore;
//       await userRef.update({'score': updatedScore});
//     } else {
//       // If the document doesn't exist, create a new document for the user
//       await userRef.set({'score': newScore});
//     }
//   } catch (error) {
//     print('Error adding or updating user score: $error');
//   }
// }

// Future<int?> fetchUserScore(String userId) async {
//   try {
//     final userRef =
//         FirebaseFirestore.instance.collection('userData').doc(userId);
//     final userDoc = await userRef.get();

//     if (userDoc.exists) {
//       final userData = userDoc.data();
//       final userScore = userData?['score'];
//       return userScore as int?;
//     } else {
//       // Document does not exist, return null or handle accordingly
//       return null;
//     }
//   } catch (error) {
//     print('Error fetching user score: $error');
//     return null;
//   }
// }


