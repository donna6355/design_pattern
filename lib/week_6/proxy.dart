import 'package:flutter/material.dart';

abstract class ImageService {
  Future<String> loadImageUrl();
}

class RealImageService implements ImageService {
  @override
  Future<String> loadImageUrl() async {
    print("RealImageService: Fetching from server...");
    await Future.delayed(Duration(seconds: 2)); // simulate network delay
    return "https://picsum.photos/300"; // Example image
  }
}

class ImageServiceProxy implements ImageService {
  final RealImageService _realService = RealImageService();
  String? _cachedUrl;

  @override
  Future<String> loadImageUrl() async {
    if (_cachedUrl != null) {
      print("Proxy: Returning cached image.");
      return _cachedUrl!;
    }

    print("Proxy: Delegating to RealImageService...");
    _cachedUrl = await _realService.loadImageUrl();
    return _cachedUrl!;
  }
}

class ProxyPage extends StatefulWidget {
  const ProxyPage({super.key});

  @override
  State<ProxyPage> createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> {
  final ImageService imageService = ImageServiceProxy();

  String? img;

  void loadImage() async {
    final url = await imageService.loadImageUrl();
    setState(() => img = url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Proxy Pattern Example")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              '- structural software design pattern\n- allows the interface of an existing class to be used as another interface',
            ),
            Divider(height: 20, thickness: 1),
            img != null
                ? Image.network(img!)
                : Text("Press the button to load image"),
            SizedBox(height: 20),
            ElevatedButton(onPressed: loadImage, child: Text("Load Image")),
          ],
        ),
      ),
    );
  }
}
