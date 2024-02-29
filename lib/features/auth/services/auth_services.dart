import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win/models/profile_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProfileModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return ProfileModel.fromMap(snap);
  }

  Future<String> logIn({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || password.isEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Logged in";
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
      } else {
        res = "Please enter email and password";
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> signupUser({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          displayName.isNotEmpty ||
          phoneNumber.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        ProfileModel user = ProfileModel(
          displayName: displayName,
          email: email,
          phoneNumber: phoneNumber,
          uid: userCredential.user!.uid,
        );
        _firestore.collection('users').doc(userCredential.user!.uid).set(
              user.toJson(),
            );
        res = "Signed up";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else {
        res = e.toString();
      }
    } catch (e) {
      res = e.toString();

      print(res);
    }
    return res;
  }
}
