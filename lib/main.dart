import 'package:design_pattern/week4/factory_method.dart';
import 'package:design_pattern/week_1/strategy.dart';
import 'package:design_pattern/week_1/template_method.dart';
import 'package:design_pattern/week_2/observer.dart';
import 'package:design_pattern/week_3/composite.dart';
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
      routes: {
        '/strategy': (context) => const StrategyPage(),
        '/template': (context) => const TemplateMethodPage(),
        '/observer': (context) => const ObserverPage(),
        '/decorator': (context) => const CompositePage(),
        '/composite': (context) => const CompositePage(),
        '/factory': (context) => const FactoryPage(),
      },
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
              Image.network(mirImg),
              Text('미르 야옹 "나는 눈을 감고 꾹꾹이를 할테니, 너는 코딩을 하여라"'),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/strategy'),
                child: Text("Strategy Pattern"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/template'),
                child: Text("Template Method Pattern"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/observer'),
                child: Text("Observer Pattern"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/composite'),
                child: Text("Composite Pattern"),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/factory'),
                child: Text("Factroy Method Pattern"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
