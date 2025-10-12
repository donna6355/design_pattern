/*
Observer Pattern
- behavioral software design pattern
- subject automatically notifies observers of any state changes 
 */

import 'package:flutter/material.dart';

import '../week_1/template_method.dart';

const String _hairBall =
    'https://media.istockphoto.com/id/1058884970/vector/knitting-icon.jpg?s=612x612&w=0&k=20&c=w3aqfskNv1ncqWEAEE4RKolKJ2WWl-UMiZ1qW_yP5O0=';
const String _catDoll =
    'https://www.clipartmax.com/png/middle/269-2695850_cat-icon-cat-icon-png.png';

class Counter extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MirHairBall extends StatelessWidget {
  final Counter counter;
  const MirHairBall({required this.counter, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: counter,
      builder: (context, _) {
        debugPrint("MirHairBall listening... ${counter.count}times brushing");
        return Row(
          children: [
            Image.network(_hairBall, width: 40),
            Text('${counter.count ~/ 5}개'),
          ],
        );
      },
    );
  }
}

class MirDoll extends StatelessWidget {
  final Counter counter;
  const MirDoll({required this.counter, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: counter,
      builder: (context, _) {
        debugPrint("MirDoll listening... ${counter.count}times brushing");
        return Row(
          children: [
            Image.network(_catDoll, width: 40),
            Text('${counter.count ~/ 10}개'),
          ],
        );
      },
    );
  }
}

class MirBrush extends StatelessWidget {
  final Counter counter;

  const MirBrush({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: counter,
      builder: (context, _) {
        debugPrint("MirBrush listening... ${counter.count}times brushing");
        return Text('빗질 ${counter.count}번');
      },
    );
  }
}

class ObserverPage extends StatefulWidget {
  const ObserverPage({super.key});

  @override
  State<ObserverPage> createState() => _ObserverPageState();
}

class _ObserverPageState extends State<ObserverPage> {
  final Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Strategy Pattern')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              '- behavioral software design pattern\n- subject automatically notifies observers of any state changes ',
            ),
            Divider(height: 20, thickness: 1),
            Text(
              '미르 빗질해주기\n빗질 5번 == 털공 1개 획득, 털공 2개 == 미니 미르 인형 1개 획득\n#일대다 #자동갱신',
            ),
            Divider(height: 20, thickness: 1),
            Align(
              alignment: Alignment.centerRight,
              child: MirBrush(counter: counter),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: counter.increment,
                child: Image.network(mirImg),
              ),
            ),
            Row(
              children: [
                Expanded(child: MirHairBall(counter: counter)),
                Expanded(child: MirDoll(counter: counter)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
