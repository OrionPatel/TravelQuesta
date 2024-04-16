import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mappls_hackathon/logic.dart';

class transScreen extends ConsumerStatefulWidget {
  const transScreen({Key? key}) : super(key: key);

  @override
  _transScreenState createState() => _transScreenState();
}

class _transScreenState extends ConsumerState<transScreen> {
  void pushReplacement(BuildContext context) {
    // ref.read(executeAuthentication);
    context.go('/home/guesser/card', extra: 'Data from splash screen');
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(milliseconds: 50), () => pushReplacement(context));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }
}
