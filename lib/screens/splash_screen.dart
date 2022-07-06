import 'dart:async';

import 'package:assessment2_app/providers/cart_provider.dart';
import 'package:assessment2_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _timer();
  }

  void _timer() {
    Timer(const Duration(seconds: 5), () async {
      await Navigator.of(context).push(MaterialPageRoute(builder: (c) {
        return ChangeNotifierProvider(
            create: (context) => Cart(), child: HomeScreen());
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          'AJIO',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
      ),
    );
  }
}
