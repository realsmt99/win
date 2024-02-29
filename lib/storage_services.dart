import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> deleteImage(String url) async {
    String res = "Some error occurred";
    try {
      await _storage.refFromURL(url).delete();
      res = "Deleted";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> uploadImageToStorage(String childname, Uint8List file) async {
    Reference ref =
        _storage.ref().child(childname).child(_auth.currentUser!.uid);

    UploadTask uploadTask =
        ref.putData(file); // controll our upload task to the firebasestorage
    TaskSnapshot snap = await uploadTask; //
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

pickImage(ImageSource source) async {
  final _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: source);
  if (image != null) return await image.readAsBytes();

  print('No image selected');
}

ShowSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      duration: Duration(seconds: 2),
    ),
  );
}
