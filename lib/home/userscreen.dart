import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logic.dart';

User? user;
final FirebaseAuth _auth = FirebaseAuth.instance;

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;
    final totalScore = ref.watch(userTotalScoreProvider);
    var values = ref.watch(scoreProvider).map.values;
    int result = values.reduce((sum, element) => sum + element);
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(user!.photoURL ??
                                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fstackoverflow.com%2Fquestions%2F49461908%2Fimagemagick-creating-blank-transparent-squares-according-to-width&psig=AOvVaw0z85m_VAWlANARo_LjX3Y1&ust=1712412862282000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKiUw5ahq4UDFQAAAAAdAAAAABAE')
                                // child: UserImage(
                                //     imageUrl: user!.photoURL,
                                //     defaultAssetImage: 'assets/user_default.png'),
                                ),
                          ),
                        ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${user.displayName}',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '${user.email}',
                              style: TextStyle(
                                color: Colors.amber,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 3,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Your Total Score: ${ref.read(scoreProvider).map['total']}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        height: 3,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        height: 3,
                        color: Colors.amber,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        SizedBox(
                          width: 120,
                          child: MaterialButton(
                            color: Colors.amber,
                            onPressed: () {
                              _auth.signOut();
                              context.go('/login');
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Log Out',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
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

class UserImage extends StatelessWidget {
  final String? imageUrl;
  final String defaultAssetImage;

  const UserImage({
    super.key,
    required this.imageUrl,
    required this.defaultAssetImage,
  });

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? FadeInImage(
            placeholder: AssetImage(defaultAssetImage),
            image: NetworkImage(imageUrl!),
            fit: BoxFit.cover)
        : Image.asset(
            defaultAssetImage,
            fit: BoxFit.cover,
          );
  }
}
