import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        context.go('/auth');
      }
    });

    return Scaffold(
      body: Center(
        child: Text("Soterix IQ", style: TextStyle(fontSize: 35),),
      ),
    );
  }
}
