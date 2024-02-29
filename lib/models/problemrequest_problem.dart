// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:latlng/latlng.dart';

import 'package:win/models/profile_model.dart';

class ProblemRequest {
  final String problemid;
  final String? fixPhonenumber;
  final ProfileModel client;
  final String problemDescription;
  final String problemType;
  final List<String> attachements;
  final String status;
  final List<ProfileModel> telecomEngineers;
  final List<String> engineersUid;
  final double? langitude;
  final double? latitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  ProblemRequest({
    required this.problemType,
    this.fixPhonenumber,
    this.langitude,
    this.latitude,
    required this.problemid,
    required this.client,
    required this.problemDescription,
    required this.attachements,
    required this.status,
    required this.telecomEngineers,
    required this.engineersUid,
    required this.createdAt,
    required this.updatedAt,
  });

  ProblemRequest copyWith({
    String? fixPhonenumber,
    double? latitude,
    double? langitude,
    String? problemid,
    ProfileModel? client,
    String? problemDescription,
    List<String>? attachements,
    String? status,
    List<ProfileModel>? telecomEngineers,
    List<String>? engineersUid,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? problemType,
  }) {
    return ProblemRequest(
      problemType: problemType ?? this.problemType,
      fixPhonenumber: fixPhonenumber ?? this.fixPhonenumber,
      latitude: langitude ?? this.langitude,
      langitude: langitude ?? this.langitude,
      problemid: problemid ?? this.problemid,
      client: client ?? this.client,
      problemDescription: problemDescription ?? this.problemDescription,
      attachements: attachements ?? this.attachements,
      status: status ?? this.status,
      telecomEngineers: telecomEngineers ?? this.telecomEngineers,
      engineersUid: engineersUid ?? this.engineersUid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'problemType': problemType,
      'fixPhonenumber': fixPhonenumber,
      'langitude': langitude,
      'latitude': latitude,
      'problemid': problemid,
      'client': client.toJson(),
      'problemDescription': problemDescription,
      'attachements': attachements,
      'status': status,
      'telecomEngineers': telecomEngineers.map((x) => x.toJson()),
      'engineersUid': engineersUid,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ProblemRequest.fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProblemRequest(
        problemType: snapshot['problemType'] as String,
        fixPhonenumber: snapshot['fixPhonenumber'] as String,
        latitude: snapshot['latitude'] as double,
        langitude: snapshot['langitude'] as double,
        engineersUid: List<String>.from(snapshot['engineersUid']),
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(snapshot['createdAt'] as int),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(snapshot['updatedAt'] as int),
        telecomEngineers: List<ProfileModel>.from(
            snapshot['telecomEngineers'].map((x) => ProfileModel.fromMap(x))),
        status: snapshot['status'] as String,
        problemid: snapshot['problemid'] as String,
        client: ProfileModel.fromMap(snapshot['client']),
        problemDescription: snapshot['problemDescription'] as String,
        attachements: List<String>.from(
          (snap['attachements']),
        ));
  }

  @override
  String toString() {
    return 'ProblemRequest(problemid: $problemid, client: $client, problemDescription: $problemDescription, attachements: $attachements, status: $status, telecomEngineers: $telecomEngineers, engineersUid: $engineersUid, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ProblemRequest other) {
    if (identical(this, other)) return true;

    return other.problemid == problemid &&
        other.client == client &&
        other.problemDescription == problemDescription &&
        listEquals(other.attachements, attachements) &&
        other.status == status &&
        listEquals(other.telecomEngineers, telecomEngineers) &&
        listEquals(other.engineersUid, engineersUid) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return problemid.hashCode ^
        client.hashCode ^
        problemDescription.hashCode ^
        attachements.hashCode ^
        status.hashCode ^
        telecomEngineers.hashCode ^
        engineersUid.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

enum ProblemRequestStatus { pending, inprogress, completed }
