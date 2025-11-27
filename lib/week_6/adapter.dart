import 'package:flutter/material.dart';

abstract class AudioPlayer {
  void play(String fileName);
}

class LegacyAudioPlayer {
  void startFile(String file) {
    print("Playing using LEGACY: $file");
  }
}

class LegacyAudioAdapter implements AudioPlayer {
  final LegacyAudioPlayer legacy;

  LegacyAudioAdapter(this.legacy);

  @override
  void play(String fileName) {
    legacy.startFile(fileName); // convert call
  }
}

class AdapterPage extends StatelessWidget {
  const AdapterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer player = LegacyAudioAdapter(LegacyAudioPlayer());
    return Scaffold(
      appBar: AppBar(title: Text("Adapter Pattern")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              '- structural software design pattern\n- allows the interface of an existing class to be used as another interface',
            ),
            Divider(height: 20, thickness: 1),
            ElevatedButton(
              onPressed: () => player.play("sound.mp3"),
              child: Text("Play Audio"),
            ),
          ],
        ),
      ),
    );
  }
}
