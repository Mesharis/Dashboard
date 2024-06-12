import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_category.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/image_carousel_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/order_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/settings_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/transaction_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/users_model.dart';
import 'package:hello_doctor_admin_dashboard/app/models/withdraw_request_model.dart';

///Firebase collection class to make it easy accessing the firebase collection, if you wanto add new collection
///Just add collection name, and create CollectionReference base on the class model, and initialize it in FirebaseCollection._internal function
///Make sure you follow the template
class FirebaseCollection {
  /// User Collection base on firebase collection name
  static const String userCollectionName = "Users";
  static const String doctorCollectionName = "Doctors";
  static const String categoryCollectionName = "DoctorCategory";
  static const String settingsCollectionName = "Settings";
  static const String orderCollectionName = "Order";
  static const String withdrawRequestCollectionName = "WithdrawRequest";
  static const String transactionCollectionName = "Order";
  static const String topRatedDoctorCollectionName = "TopRatedDoctor";
  static const String imageCarouselCollectionName = "listImage";

  static final FirebaseCollection _singleton = FirebaseCollection._internal();
  static final Map<Type, CollectionReference<dynamic>> _collectionCache = {};
  late CollectionReference<UsersModel> usersCol;
  late CollectionReference<Doctor> doctorCol;
  late CollectionReference<DoctorCategory> categoryCol;
  late CollectionReference<SettingsModel> settingsCol;
  late CollectionReference<OrderModel> orderCol;
  late CollectionReference<WithdrawRequestModel> withdrawRequestCol;
  late CollectionReference<TransactionModel> transactionCol;
  late CollectionReference<ImageCarouselModel> imageCarouselCol;
  late CollectionReference<List<String>> topRatedDoctorCol;
  factory FirebaseCollection() {
    return _singleton;
  }

  FirebaseCollection._internal() {
    usersCol = _getOrCreateCollection<UsersModel>(
        collectionName: userCollectionName,
        fromJson: UsersModel.fromFirestore,
        toJson: (UsersModel model) => model.toJson());
    doctorCol = _getOrCreateCollection<Doctor>(
        collectionName: doctorCollectionName,
        fromJson: Doctor.fromFirestore,
        toJson: (Doctor model) => model.toJson());
    categoryCol = _getOrCreateCollection<DoctorCategory>(
        collectionName: categoryCollectionName,
        fromJson: DoctorCategory.fromFirestore,
        toJson: (DoctorCategory model) => model.toJson());
    settingsCol = _getOrCreateCollection<SettingsModel>(
        collectionName: settingsCollectionName,
        fromJson: SettingsModel.fromFirestore,
        toJson: (SettingsModel model) => model.toJson());
    withdrawRequestCol = _getOrCreateCollection<WithdrawRequestModel>(
        collectionName: withdrawRequestCollectionName,
        fromJson: WithdrawRequestModel.fromFirestore,
        toJson: (WithdrawRequestModel model) => model.toJson());
    transactionCol = _getOrCreateCollection<TransactionModel>(
        collectionName: transactionCollectionName,
        fromJson: TransactionModel.fromFirestore,
        toJson: (TransactionModel model) => model.toJson());
    imageCarouselCol = _getOrCreateCollection<ImageCarouselModel>(
        collectionName:
            '$settingsCollectionName/imageCarousel/$imageCarouselCollectionName',
        fromJson: ImageCarouselModel.fromFirestore,
        toJson: (ImageCarouselModel model) => model.toJson());
  }
  static CollectionReference<T> _getOrCreateCollection<T>(
      {required String collectionName,
      required T Function(DocumentSnapshot doc) fromJson,
      required Map<String, dynamic> Function(T model) toJson}) {
    final type = T;
    if (_collectionCache.containsKey(type)) {
      return _collectionCache[type] as CollectionReference<T>;
    }
    final collection =
        FirebaseFirestore.instance.collection(collectionName).withConverter<T>(
              fromFirestore: (snapshot, _) => fromJson(snapshot),
              toFirestore: (value, _) => toJson(value),
            );
    _collectionCache[type] = collection;
    return collection;
  }
}
