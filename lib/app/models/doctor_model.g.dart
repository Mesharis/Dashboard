// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      doctorPicture: json['doctorPicture'] as String?,
      doctorPrice: json['doctorBasePrice'] as int?,
      doctorShortBiography: json['doctorBiography'] as String?,
      doctorCategory: json['doctorCategory'] == null
          ? null
          : DoctorCategory.fromJson(
              json['doctorCategory'] as Map<String, dynamic>),
      doctorHospital: json['doctorHospital'] as String?,
      doctorBalance: json['balance'] as int?,
      accountStatus: json['accountStatus'] as String?,
      topRated: json['topRated'] as bool?,
    )
      ..createdAt = Doctor._dateTimeFromJson(json['createdAt'] as Timestamp?)
      ..updatedAt = Doctor._dateTimeFromJson(json['updatedAt'] as Timestamp?);

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'doctorId': instance.doctorId,
      'doctorName': instance.doctorName,
      'doctorPicture': instance.doctorPicture,
      'doctorBasePrice': instance.doctorPrice,
      'doctorBiography': instance.doctorShortBiography,
      'doctorCategory': instance.doctorCategory,
      'doctorHospital': instance.doctorHospital,
      'balance': instance.doctorBalance,
      'accountStatus': instance.accountStatus,
      'createdAt': Doctor._dateTimeToJson(instance.createdAt),
      'updatedAt': Doctor._dateTimeToJson(instance.updatedAt),
      'topRated': instance.topRated,
    };
