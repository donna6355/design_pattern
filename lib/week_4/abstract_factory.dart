import 'package:design_pattern/week_4/factory_method.dart';
import 'package:flutter/material.dart';

abstract class LevelFactory {
  Color get levelColor;
  Widget renderBadge();
  Widget renderCommunityEntry();
  Widget renderLoungeEntry();
}

class BeginnerFactory extends LevelFactory {
  @override
  Color get levelColor => Colors.red;
  @override
  Widget renderBadge() => Icon(Icons.eco, size: 32, color: levelColor);

  @override
  Widget renderCommunityEntry() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.block),
        Text('커뮤니티는 중급 이상 이용 가능합니다.', style: TextStyle(color: levelColor)),
      ],
    );
  }

  @override
  Widget renderLoungeEntry() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.block),
        Text('라운지는 고급 이상 이용 가능합니다.', style: TextStyle(color: levelColor)),
      ],
    );
  }
}

class IntermediateFactory extends LevelFactory {
  @override
  Color get levelColor => Colors.orange;
  @override
  Widget renderBadge() => Icon(Icons.sunny, size: 32, color: levelColor);

  @override
  Widget renderCommunityEntry() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: levelColor),
      child: Text('커뮤니티 입장하기'),
    );
  }

  @override
  Widget renderLoungeEntry() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.block),
        Text('라운지는 고급 이상 이용 가능합니다.', style: TextStyle(color: levelColor)),
      ],
    );
  }
}

class AdvancedFactory extends LevelFactory {
  @override
  Color get levelColor => Colors.yellow;
  @override
  Widget renderBadge() => Icon(Icons.star, size: 32, color: levelColor);

  @override
  Widget renderCommunityEntry() => ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: levelColor),
    child: Text('커뮤니티 입장하기'),
  );

  @override
  Widget renderLoungeEntry() => ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: levelColor),
    child: Text('라운지 입장하기'),
  );
}

class MasterFactory extends LevelFactory {
  @override
  Color get levelColor => Colors.blue;

  @override
  Widget renderBadge() => Icon(Icons.diamond, size: 32, color: levelColor);

  @override
  Widget renderCommunityEntry() => ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(backgroundColor: levelColor),
    child: Text('커뮤니티 입장하기'),
  );

  @override
  Widget renderLoungeEntry() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(backgroundColor: levelColor),
        child: Text('라운지 입장하기'),
      ),
      IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
    ],
  );
}

class LevelFactoryProvider {
  static LevelFactory getFactory(UserLevel level) {
    switch (level) {
      case UserLevel.beginner:
        return BeginnerFactory();
      case UserLevel.intermediate:
        return IntermediateFactory();
      case UserLevel.advanced:
        return AdvancedFactory();
      case UserLevel.master:
        return MasterFactory();
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
            LevelFactoryProvider.getFactory(user.level).renderBadge(),
          ],
        ),
        Text(user.name),
      ],
    );
  }
}

class UserDashboard extends StatelessWidget {
  final User user;
  const UserDashboard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final LevelFactory factory = LevelFactoryProvider.getFactory(user.level);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(16, 40, 16, 8),
          padding: const EdgeInsets.only(top: 64, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(),
          ),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("환영합니다:)"),
              factory.renderCommunityEntry(),
              factory.renderLoungeEntry(),
            ],
          ),
        ),
        UserProfile(user: user),
      ],
    );
  }
}

class AbstractFactoryPage extends StatelessWidget {
  const AbstractFactoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Abstract Factory')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '- create families of related objects without imposing their concrete classes, by encapsulating a group of individual factories that have a common theme without specifying their concrete classes',
              ),
              Divider(height: 20, thickness: 1),
              Text(
                '사용자 대쉬보드에는 등급에 따라 접근할 수 있는 커뮤니티, 라운지 기능을 표시한다.\n접근 권한이 없는 경우는 “접근 불가"를 보여주고, 권한이 있는 경우는 입장할 수 있는 버튼을 보여준다.',
              ),
              Divider(height: 20, thickness: 1),
              ...[
                for (var user in users)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserDashboard(user: user),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
