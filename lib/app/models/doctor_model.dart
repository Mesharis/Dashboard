import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class Doctor {
  String? id;
  @JsonKey(name: 'doctorId')
  String? doctorId;
  @JsonKey(name: 'doctorName')
  String? doctorName;
  @JsonKey(name: 'doctorPicture')
  String? doctorPicture;
  @JsonKey(name: 'doctorBasePrice')
  int? doctorPrice;
  @JsonKey(name: 'doctorBiography')
  String? doctorShortBiography;
  @JsonKey(name: 'doctorCategory')
  DoctorCategory? doctorCategory;
  @JsonKey(name: 'doctorHospital')
  String? doctorHospital;
  @JsonKey(name: 'balance')
  int? doctorBalance;
  @JsonKey(name: 'accountStatus')
  String? accountStatus;
  @JsonKey(
      name: 'createdAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? createdAt;
  @JsonKey(
      name: 'updatedAt', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  DateTime? updatedAt;
  @JsonKey(name: 'topRated')
  bool? topRated;

  Doctor(
      {this.id,
      this.doctorId,
      this.doctorName,
      this.doctorPicture,
      this.doctorPrice,
      this.doctorShortBiography,
      this.doctorCategory,
      this.doctorHospital,
      this.doctorBalance,
      this.accountStatus,
      this.topRated});

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
  factory Doctor.fromFirestore(DocumentSnapshot doc) =>
      Doctor.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
  static DateTime? _dateTimeFromJson(Timestamp? timestamp) =>
      timestamp?.toDate();
  static Timestamp? _dateTimeToJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
