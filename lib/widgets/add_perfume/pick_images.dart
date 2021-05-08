import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class PickImages extends StatefulWidget {
  PickImages(this.uid, {Key key}) : super(key: PickImages.staticGlobalKey);
  // PickImages(this.uid);
  static final GlobalKey<PickImagesState> staticGlobalKey =
      new GlobalKey<PickImagesState>();
  final String uid;
  @override
  PickImagesState createState() => PickImagesState();
}

class PickImagesState extends State<PickImages> {
  List<Asset> _images = List<Asset>();
  List<File> _compressedFiles = List<File>();
  // List<String> _urlList = List<String>();

  final _user = FirebaseAuth.instance.currentUser;

  int _image = 0;

  Future _createAdvertisementInDB() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.displayName)
        .get();

    await FirebaseFirestore.instance
        .collection('advertisement')
        .doc('${widget.uid}')
        .set({
      'username': _user.displayName,
      'userAvatar': userData.data()['image_url'],
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'images': 0,
      'id': widget.uid,
    });

    // await FirebaseFirestore.instance.collection('/advertisement').doc('${widget.uid}').delete();
  }

  Future _addUrlsToDB(String url) async {
    _image += 1;
    await FirebaseFirestore.instance
        .collection('advertisement')
        .doc('${widget.uid}')
        .update({
      'urlImage$_image': url,
      'images': _image,
    });

    // await FirebaseFirestore.instance.collection('/advertisement').doc('${widget.uid}').delete();
  }

  Future<File> _compressFile(File file) async {
    ImageProperties properties =
        await FlutterNativeImage.getImageProperties(file.path);
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      // quality: 100,
      // percentage: ,
      targetWidth: properties.height < properties.width ? 800 : 600,
      targetHeight: properties.width < properties.height ? 800 : 600,
    );
    _compressedFiles.add(compressedFile);
    return null;
  }

  Future handleUploadImage() async {
    _createAdvertisementInDB();
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      for (int i = 0; i < _compressedFiles.length; i++) {
        final Reference ref = storage.ref().child('advertisement');
        final UploadTask task =
            ref.child('${widget.uid}/image$i').putFile(_compressedFiles[i]);
        var imageUrl = await (await task).ref.getDownloadURL();
        var url = imageUrl.toString();
        print(url);
        _addUrlsToDB(url);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _pickImages() async {
    List<Asset> resultList = List<Asset>();
    List<File> fileImageArray = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        selectedAssets: resultList,
        materialOptions: MaterialOptions(
          actionBarTitle: "Wybierz zdjęcia",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    //convert Asset to File
    resultList.forEach((imageAsset) async {
      final filePath =
          await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier);

      File tempFile = File(filePath);
      if (tempFile.existsSync()) {
        _compressFile(tempFile);
      }
    });

    setState(() {
      _images = resultList;
      _compressedFiles = fileImageArray;
      print('${_user.email}');
    });
  }

  int _photoGrid() {
    if (_compressedFiles.length == 1) {
      return 1;
    } else if (_compressedFiles.length < 5) {
      return 2;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: _images.isEmpty ? 200 : 30),
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _images.isEmpty
                ? ButtonTheme(
                    height: 100,
                    minWidth: 100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: RaisedButton(
                      color: Colors.white,
                      child: Icon(Icons.image),
                      //Text("Wybierz zdjęcia"),
                      onPressed: _pickImages,
                    ),
                  )
                : RaisedButton(
                    color: Colors.white,
                    child: Text("Zmień zdjęcia"),
                    onPressed: _pickImages,
                  ),
            _images.isNotEmpty
                ? Container(
                    height: 400,
                    child: Center(
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: _photoGrid(),
                        children: List.generate(_images.length, (index) {
                          Asset asset = _images[index];
                          return AssetThumb(
                            asset: asset,
                            width: 300,
                            height: 300,
                            quality: 70,
                          );
                        }),
                      ),
                    ),
                  )
                : const SizedBox(),
            // _handleUploadImage()
            // RaisedButton(
            //   onPressed: () => _addUserToDB(),
            // )
          ],
        ),
      ),
    );
  }
}
