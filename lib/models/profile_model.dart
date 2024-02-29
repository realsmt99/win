import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  final String displayName;
  final String email;
  final String? phoneNumber;
  final String uid;
  ProfileModel({
    required this.displayName,
    required this.email,
    this.phoneNumber,
    required this.uid,
  });

  ProfileModel copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? uid,
  }) {
    return ProfileModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'uid': uid,
    };
  }

  factory ProfileModel.fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ProfileModel(
      displayName: snapshot['displayName'] as String,
      email: snapshot['email'] as String,
      phoneNumber: snapshot['phoneNumber'] != null
          ? snapshot['phoneNumber'] as String
          : "",
      uid: snapshot['uid'] as String,
    );
  }

  @override
  String toString() {
    return 'ProfileModel(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, uid: $uid)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        uid.hashCode;
  }
}

enum Roles {
  admin,
  client,
}
