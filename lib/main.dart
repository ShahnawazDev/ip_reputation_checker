import 'package:flutter/material.dart';
import 'package:ip_reputation_checker/ip_reputation_checker.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IpReputationChecker(),
    );
  }
}
