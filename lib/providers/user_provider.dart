import 'package:flutter/foundation.dart';
import 'package:win/models/profile_model.dart';

class UserProvider extends ChangeNotifier {
  ProfileModel _user =
      ProfileModel(displayName: '', email: '', uid: '', phoneNumber: '');

  ProfileModel get user => _user;
}
