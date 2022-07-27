// // ignore_for_file: prefer_const_constructors, invalid_use_of_visible_for_testing_member

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UserImagePicker extends StatefulWidget {
//   UserImagePicker({required this.imagePickerFn});
//   final void Function(File imageFile) imagePickerFn;

//   @override
//   State<UserImagePicker> createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   var _pickedImage;

//   Future<void> imagePicker() async {
//     final pickedImageFile =
//         await ImagePicker.platform.pickImage(source: ImageSource.camera);
//     setState(() {
//       _pickedImage = File(pickedImageFile!.path);
//     });
//     widget.imagePickerFn(_pickedImage);
//   }

// ignore_for_file: prefer_const_constructors

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           backgroundImage:
//               _pickedImage != null ? FileImage(_pickedImage as File) : null,
//         ),
//         TextButton.icon(
//           onPressed: imagePicker,
//           icon: const Icon(Icons.preview),
//           label: Text('Add Image'),
//         ),
//       ],
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImage == null) {
      return;
    }
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          // textColor: Theme.of(context).primaryColor,
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
