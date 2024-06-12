import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_doctor_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_model.dart';

class DoctorService {
  Future<List<Doctor>> getDoctors() async {
    try {
      var listDoctorRef = await FirebaseCollection().doctorCol.get();
      if (listDoctorRef.docs.isEmpty) return [];
      List<Doctor> listDoctor =
          listDoctorRef.docs.map((doc) => doc.data()).toList();
      return listDoctor;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future activateDoctor(String doctorId) async {
    try {
      await FirebaseCollection()
          .doctorCol
          .doc(doctorId)
          .update({'accountStatus': 'active'});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future bannedDoctor(String doctorId) async {
    try {
      await FirebaseCollection()
          .doctorCol
          .doc(doctorId)
          .update({'accountStatus': 'nonactive'});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getTopRatedDoctors() async {
    try {
      var doctorsRef = await FirebaseCollection()
          .doctorCol
          .where('topRated', isEqualTo: true)
          .get();
      var listTopRatedDoctor =
          doctorsRef.docs.map((doc) => doc.data()).toList();
      return listTopRatedDoctor;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future addTopRatedDoctor(String doctorId) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollection.topRatedDoctorCollectionName)
          .doc(doctorId)
          .set({'doctorId': doctorId});

      await FirebaseCollection()
          .doctorCol
          .doc(doctorId)
          .update({'topRated': true});
    } catch (e) {
      return Future.error(e);
    }
  }

  Future removeTopRatedDoctor(String doctorId) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollection.topRatedDoctorCollectionName)
          .doc(doctorId)
          .delete();
      await FirebaseCollection()
          .doctorCol
          .doc(doctorId)
          .update({'topRated': false});
    } catch (e) {
      return Future.error(e);
    }
  }
}
