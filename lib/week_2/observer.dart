/*
Observer Pattern
- behavioral software design pattern
- subject automatically notifies observers of any state changes 
 */

import 'dart:async';

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

enum MirTopic { every, five, ten }

class MirBroker {
  final Map<MirTopic, StreamController<int>> _channels = {};
  int _count = 0;

  Stream<int> subscribe<int>(MirTopic topic) {
    _channels.putIfAbsent(topic, () => StreamController.broadcast());
    return _channels[topic]!.stream as Stream<int>;
  }

  void publish() {
    _count += 1;
    _channels[MirTopic.every]!.add(_count);
    if (_count % 5 == 0) _channels[MirTopic.five]!.add(_count);
    if (_count % 10 == 0) _channels[MirTopic.ten]!.add(_count);
  }

  void dispose() {
    for (var controller in _channels.values) {
      controller.close();
    }
    _channels.clear();
  }
}

class MirBrush extends StatelessWidget {
  final MirBroker broker;
  const MirBrush({super.key, required this.broker});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: broker.subscribe(MirTopic.every),
      builder: (context, snapshot) {
        final data = snapshot.data;
        debugPrint("MirBrush listening... ${data}times brushing");
        return Text('빗질 ${data ?? 0}번');
      },
    );
  }
}

class MirHairBall extends StatelessWidget {
  final MirBroker broker;
  const MirHairBall({super.key, required this.broker});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: broker.subscribe(MirTopic.five),
      builder: (context, snapshot) {
        final data = snapshot.data;
        debugPrint("MirHairBall listening... ${data}times brushing");
        return Row(
          children: [
            Image.network(_hairBall, width: 40),
            Text('${(data ?? 0) ~/ 5}개'),
          ],
        );
      },
    );
  }
}

class MirDoll extends StatelessWidget {
  final MirBroker broker;
  const MirDoll({super.key, required this.broker});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: broker.subscribe(MirTopic.ten),
      builder: (context, snapshot) {
        final data = snapshot.data;
        debugPrint("MirDoll listening... ${data}times brushing");
        return Row(
          children: [
            Image.network(_catDoll, width: 40),
            Text('${(data ?? 0) ~/ 10}개'),
          ],
        );
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
  final MirBroker broker = MirBroker();

  @override
  void dispose() {
    broker.dispose();
    super.dispose();
  }

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
              '미르 이미지를 탭해서 빗질하고 빗질 횟수에 따라 아이템을 획득\n빗질 5번 == 털공 1개, 털공 2개 == 미니 미르 인형 1개 획득\n#일대다 #자동갱신',
            ),
            Divider(height: 20, thickness: 1),
            Align(
              alignment: Alignment.centerRight,
              child: MirBrush(broker: broker),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: broker.publish,
                child: Image.network(mirImg),
              ),
            ),
            Row(
              children: [
                Expanded(child: MirHairBall(broker: broker)),
                Expanded(child: MirDoll(broker: broker)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//Observer Pattern
// class FirstHairBall extends StatelessWidget {
//   final Counter counter;
//   const FirstHairBall({required this.counter, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: counter,
//       builder: (context, _) {
//         debugPrint("MirHairBall listening... ${counter.count}times brushing");
//         return Row(
//           children: [
//             Image.network(_hairBall, width: 40),
//             Text('${counter.count ~/ 5}개'),
//           ],
//         );
//       },
//     );
//   }
// }

// class FirstDoll extends StatelessWidget {
//   final Counter counter;
//   const FirstDoll({required this.counter, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: counter,
//       builder: (context, _) {
//         debugPrint("MirDoll listening... ${counter.count}times brushing");
//         return Row(
//           children: [
//             Image.network(_catDoll, width: 40),
//             Text('${counter.count ~/ 10}개'),
//           ],
//         );
//       },
//     );
//   }
// }

// class FirstBrush extends StatelessWidget {
//   final Counter counter;

//   const FirstBrush({super.key, required this.counter});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: counter,
//       builder: (context, _) {
//         debugPrint("MirBrush listening... ${counter.count}times brushing");
//         return Text('빗질 ${counter.count}번');
//       },
//     );
//   }
// }

// class ObserverPage extends StatefulWidget {
//   const ObserverPage({super.key});

//   @override
//   State<ObserverPage> createState() => _ObserverPageState();
// }

// class _ObserverPageState extends State<ObserverPage> {
//   final Counter counter = Counter();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Strategy Pattern')),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             Text(
//               '- behavioral software design pattern\n- subject automatically notifies observers of any state changes ',
//             ),
//             Divider(height: 20, thickness: 1),
//             Text(
//               '미르 이미지를 탭해서 빗질하고 빗질 횟수에 따라 아이템을 획득\n빗질 5번 == 털공 1개, 털공 2개 == 미니 미르 인형 1개 획득\n#일대다 #자동갱신',
//             ),
//             Divider(height: 20, thickness: 1),
//             Align(
//               alignment: Alignment.centerRight,
//               child: FirstBrush(counter: counter),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: GestureDetector(
//                 onTap: counter.increment,
//                 child: Image.network(mirImg),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(child: FirstHairBall(counter: counter)),
//                 Expanded(child: FirstDoll(counter: counter)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
