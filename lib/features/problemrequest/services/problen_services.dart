import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import 'package:win/features/auth/services/auth_services.dart';
import 'package:win/models/profile_model.dart';
import 'package:win/storage_services.dart';

import '../../../models/problemrequest_problem.dart';

class ProblemServices {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadRequest(
      {required Uint8List file,
      required String caption,
      required String problemType,
      required String uid}) async {
    String res = "Some error occurred";

    try {
      String problemId = const Uuid().v1();
      String url =
          await StorageMethods().uploadImageToStorage("Problems", file);

      ProblemRequest problemRequest = ProblemRequest(
        problemid: problemId,
        clientuid: uid,
        problemDescription: caption,
        problemType: problemType,
        attachements: [url],
        status: "Pending",
        telecomEngineers: [],
        engineersUid: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _firestore
          .collection('ProblemRequests')
          .doc(problemId)
          .set(problemRequest.toJson());

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}
