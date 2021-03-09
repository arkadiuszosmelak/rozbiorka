import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickeImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _pickedImage == null
              ? AssetImage('assets/icons/user_icon.png')
              : FileImage(_pickedImage),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
      child: FlatButton(
        child: Padding(
          padding: const EdgeInsets.only(top: 55.0),
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white70,
            ),
          ),
        ),
        onPressed: _pickImage,
      ),
    );
  }
}
