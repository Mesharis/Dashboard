import 'package:hello_doctor_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_doctor_admin_dashboard/app/models/image_carousel_model.dart';
import 'package:hello_doctor_admin_dashboard/app/services/image_service.dart';

class ImageCarouselService {
  ///get all image carousel
  Future getImageCarousel() async {
    try {
      var categoryRef = await FirebaseCollection().imageCarouselCol.get();
      List<ImageCarouselModel> listImageCarousel =
          categoryRef.docs.map((doc) => doc.data()).toList();
      return listImageCarousel;
    } catch (e) {
      return Future.error(e);
    }
  }

  ///add new image carousel, and return newly added image carousel with id
  Future<ImageCarouselModel> addImageCarousel(
      ImageCarouselModel imageCarousel) async {
    try {
      var newImageCarouselRef =
          await FirebaseCollection().imageCarouselCol.add(imageCarousel);
      imageCarousel.id = newImageCarouselRef.id;
      return imageCarousel;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future updateImageCarousel(ImageCarouselModel imageCarousel) async {
    try {
      await FirebaseCollection()
          .imageCarouselCol
          .doc(imageCarousel.id)
          .update(imageCarousel.toJson());
    } catch (e) {
      return Future.error(e);
    }
  }

  ///remove image carousel base on id
  Future removeImageCarousel(String imageCarouselId, String imageUrl) async {
    try {
      await FirebaseCollection().imageCarouselCol.doc(imageCarouselId).delete();
      await ImageService().removeImage(imageUrl);
    } catch (e) {
      return Future.error(e);
    }
  }
}
