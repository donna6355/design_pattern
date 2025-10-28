import 'package:flutter/material.dart';

final List<User> users = [
  User(
    name: 'Mir Isaac',
    img: 'https://avatars.githubusercontent.com/u/71857113?s=80&v=4',
    level: UserLevel.beginner,
  ),
  User(
    name: 'Bob',
    img:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Robert_C._Martin_surrounded_by_computers_%28cropped%29.jpg/250px-Robert_C._Martin_surrounded_by_computers_%28cropped%29.jpg',
    level: UserLevel.intermediate,
  ),
  User(
    name: 'Charlie',
    img: 'https://i.pravatar.cc/150?img=3',
    level: UserLevel.advanced,
  ),
  User(
    name: 'Aiden',
    img:
        'https://miro.medium.com/v2/resize:fill:176:176/1*DEjvyuB1Opd9uMg94cRDAw.png',
    level: UserLevel.master,
  ),
];

class User {
  final String name;
  final String img;
  final UserLevel level;
  User({required this.name, required this.img, required this.level});
}

enum UserLevel { beginner, intermediate, advanced, master }

abstract class LevelCreator {
  Widget renderBadge();
}

class BeginnerCreator extends LevelCreator {
  @override
  Widget renderBadge() => Icon(Icons.eco, size: 32, color: Colors.red);
}

class IntermediateCreator extends LevelCreator {
  @override
  Widget renderBadge() => Icon(Icons.sunny, size: 32, color: Colors.orange);
}

class AdvancedCreator extends LevelCreator {
  @override
  Widget renderBadge() => Icon(Icons.star, size: 32, color: Colors.yellow);
}

class MasterCreator extends LevelCreator {
  @override
  Widget renderBadge() => Icon(Icons.diamond, size: 32, color: Colors.blue);
}

class LevelCreatorProvider {
  static LevelCreator getFactory(UserLevel level) {
    switch (level) {
      case UserLevel.beginner:
        return BeginnerCreator();
      case UserLevel.intermediate:
        return IntermediateCreator();
      case UserLevel.advanced:
        return AdvancedCreator();
      case UserLevel.master:
        return MasterCreator();
    }
  }
}

class UserProfile extends StatelessWidget {
  final User user;
  const UserProfile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipOval(
              child: Image.network(
                user.img,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            LevelCreatorProvider.getFactory(user.level).renderBadge(),
          ],
        ),
        Text(user.name),
      ],
    );
  }
}

//enum approach
// enum UserLevel {
//   beginner(Icon(Icons.eco, size: 32, color: Colors.red)),
//   intermediate(Icon(Icons.sunny, size: 32, color: Colors.orange)),
//   advanced(Icon(Icons.star, size: 32, color: Colors.yellow)),
//   master(Icon(Icons.diamond, size: 32, color: Colors.blue));

//   final Widget levelBadge;

//   const UserLevel(this.levelBadge);
// }

// class UserProfile extends StatelessWidget {
//   final User user;
//   const UserProfile({required this.user, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.bottomRight,
//           children: [
//             ClipOval(
//               child: Image.network(
//                 user.img,
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             user.level.levelBadge,
//           ],
//         ),
//         Text(user.name),
//       ],
//     );
//   }
// }

class FactoryPage extends StatelessWidget {
  const FactoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Factory Pattern')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '- uses factory methods to deal with the problem of creating objects without having to specify their exact classes',
            ),
            Divider(height: 20, thickness: 1),
            Text(
              '사용자는 등급에 따라 초급, 중급, 고급, 마스터로 나누어진다.\n각 사용자의 프로필 이미지 옆에는 등급에 따른 아이콘을 표시해 준다.',
            ),
            Divider(height: 20, thickness: 1),
            ...[
              for (var user in users)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserProfile(user: user),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
