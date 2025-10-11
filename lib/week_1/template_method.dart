/*
Template Method Pattern
- behavioral software design pattern
- defines the template of an algorithm in a base class, letting subclasses override certain steps without changing the overall process
 */

import 'dart:math';

import 'package:flutter/material.dart';

const String _mirImg =
    "https://play-lh.googleusercontent.com/KzLezqL9qrAf1cG-84JOP7kvWQh9P2K9_GZefPlvKgyi-35oQvkfrNNU2vt7tw-vrFg=w240-h480-rw";

class MirFile {}

abstract class ImageUploader {
  //Template : getImage -> img check -> size check -> upload
  Future<(bool success, String? err, String? url)> saveUserImage() async {
    final imgFile = await getImage();
    if (imgFile == null) return (false, "No Image Attached", null);
    debugPrint("Get Image File");
    final withinSize = checkFileSize(imgFile);
    if (!withinSize) return (false, "Too Big Image", null);
    debugPrint("File Size Fine");
    final isSuccess = await uploadImage();
    return isSuccess ? (true, null, _mirImg) : (false, "Upload Failure", null);
  }

  //take photo, select from gallery or file system
  Future<MirFile?> getImage();

  bool checkFileSize(MirFile file) {
    //for random result
    final random = Random();
    return random.nextBool();
  }

  Future<bool> uploadImage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    //for random result
    final random = Random();
    return random.nextBool();
  }
}

class CameraImgUploader extends ImageUploader {
  @override
  Future<MirFile?> getImage() async {
    await Future.delayed(const Duration(milliseconds: 200));
    //always return file for test
    return MirFile();
  }
}

class GalleryImgUploader extends ImageUploader {
  @override
  Future<MirFile?> getImage() async {
    await Future.delayed(const Duration(milliseconds: 200));
    //always return null for test
    return null;
  }
}

class TemplateMethodPage extends StatefulWidget {
  const TemplateMethodPage({super.key});

  @override
  State<TemplateMethodPage> createState() => _TemplateMethodPageState();
}

class _TemplateMethodPageState extends State<TemplateMethodPage> {
  String? _errMsg;
  String? _imgUrl;
  bool _uploadeDone = false;
  bool _isLoading = false;

  Future<void> _displaySaveImgResult(ImageUploader obj) async {
    setState(() => _isLoading = true);
    final (success, err, url) = await obj.saveUserImage();
    setState(() {
      _isLoading = false;
      _uploadeDone = success;
      _errMsg = err;
      _imgUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Strategy Pattern')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- behavioral software design pattern\n- defines the template of an algorithm in a base class, letting subclasses override certain steps without changing the overall process',
                ),
                Divider(height: 20, thickness: 1),
                Text(
                  '이미지 파일 첨부 기능 구현 필요\n화면에는 ‘사진 찍기’, ‘갤러리에서 선택하기’ 두개의 버튼 배치\n첨부파일은 1개, 5mb 이하로 가능\n첨부파일을 선택하면 서버에 저장 후 화면에 표시\n#추상화 #재사용 #탬플릿',
                ),
                Divider(height: 20, thickness: 1),
                ElevatedButton(
                  onPressed: () => _displaySaveImgResult(CameraImgUploader()),
                  child: Text('사진 찍기'),
                ),
                ElevatedButton(
                  onPressed: () => _displaySaveImgResult(GalleryImgUploader()),
                  child: Text('갤러리에서 이미지 선택하기'),
                ),

                if (_uploadeDone)
                  Text(
                    "이미지 업로드 성공!!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                if (_errMsg != null)
                  Text(_errMsg!, style: TextStyle(color: Colors.red)),
                if (_imgUrl != null) Image.network(_imgUrl!),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
