import 'package:design_pattern/week_1/strategy.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GOE DESIGN PATTERN YAY',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: MirStudyHome(),
      routes: {'/strategy': (context) => const StrategyPage()},
    );
  }
}

class MirStudyHome extends StatelessWidget {
  const MirStudyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Study Hard && Meow Hard")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            spacing: 8,
            children: [
              Image.network(
                'https://file.notion.so/f/f/f53fd55a-5c20-44ad-a09b-ba0e39b16877/e251fe3e-d538-4a5d-b5a8-12dbb2cbbd56/laundry.gif?table=block&id=41d4d121-2c23-4065-931b-b2ab4213c264&spaceId=f53fd55a-5c20-44ad-a09b-ba0e39b16877&expirationTimestamp=1760176800000&signature=P0QYZEGKmT2yBe4U0t4Z9lTCbt2GRekdY3c57xFwm_c',
              ),
              Text('미르 야옹 "나는 눈을 감고 꾹꾹이를 할테니, 너는 코딩을 하여라"'),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/strategy'),
                child: Text("Strategy Pattern"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
