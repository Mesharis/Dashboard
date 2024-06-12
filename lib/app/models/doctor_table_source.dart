import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_doctor_admin_dashboard/app/models/doctor_model.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/doctors/views/detail_doctor_content.dart';
import 'package:hello_doctor_admin_dashboard/app/utils/timeformat.dart';

class DoctorTableSource extends DataTableSource {
  late final List<Doctor> listDoctor;
  late DoctorsController doctorsController;
  DoctorTableSource(this.listDoctor) {
    doctorsController = Get.find<DoctorsController>();
  }
  @override
  DataRow? getRow(int index) {
    // ImageProvider imageProvider = listDoctor[index].doctorPicture != null
    //     ? NetworkImage(listDoctor[index].doctorPicture!) as ImageProvider
    //     : const AssetImage('/assets/images/default-profile.png');
    return DataRow(cells: [
      // DataCell(Image.network(
      //   listDoctor[index].doctorPicture!,
      //   height: 20,
      // )),
      DataCell(Text(listDoctor[index].doctorName ?? '')),
      DataCell(Text(
          TimeFormat().formatDate(listDoctor[index].createdAt).toString())),
      DataCell(Text(listDoctor[index].doctorCategory?.categoryName ?? '')),
      DataCell(Text(listDoctor[index].doctorShortBiography.toString())),
      DataCell(Text(listDoctor[index].doctorHospital.toString())),
      DataCell(Text(listDoctor[index].accountStatus.toString())),
      DataCell(
        Row(
          children: [
            listDoctor[index].accountStatus == 'active'
                ? Tooltip(
                    message: 'Banned Account',
                    child: IconButton(
                      icon: const Icon(Icons.block),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Banned Account",
                            content: const Text(
                              'Are you sure you want to banned this doctor account? This doctor will be not visible to all Client',
                              textAlign: TextAlign.center,
                            ),
                            textCancel: 'Cancel',
                            textConfirm: 'Banned Doctor',
                            onConfirm: () {
                              Get.back();
                              doctorsController
                                  .disabledDoctor(listDoctor[index].id!);
                            });
                      },
                    ),
                  )
                : Tooltip(
                    message: 'Activate Account',
                    child: IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Activate Account",
                            content: const Text(
                              'Are you sure 7you want to activate this doctor account? This doctor will be visible to all Client and can receive timeslot orders',
                              textAlign: TextAlign.center,
                            ),
                            textCancel: 'Cancel',
                            textConfirm: 'Ok',
                            onConfirm: () {
                              Get.back();
                              doctorsController
                                  .activateDoctor(listDoctor[index].id!);
                            });
                      },
                    ),
                  ),
            (listDoctor[index].topRated == null ||
                    listDoctor[index].topRated == false)
                ? Tooltip(
                    message: 'Set Top Rated Doctor',
                    child: IconButton(
                      icon: const Icon(Icons.star_border_purple500_outlined),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Set Top Rated Doctor",
                            content: const Text(
                              'Set this doctor as a top rated doctor, this doctor will be promoted on the client\'s home page',
                              textAlign: TextAlign.center,
                            ),
                            textCancel: 'Cancel',
                            textConfirm: 'Set Top Rated',
                            onConfirm: () {
                              Get.back();
                              doctorsController
                                  .addToTopRatedDoctor(listDoctor[index].id!);
                            });
                      },
                    ),
                  )
                : Tooltip(
                    message: 'Remove Top Rated Doctor',
                    child: IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Remove Top Rated Doctor",
                            content: const Text(
                              'Remove Top Rated Doctor',
                              textAlign: TextAlign.center,
                            ),
                            textCancel: 'Cancel',
                            textConfirm: 'Remove Top Rated Doctor',
                            onConfirm: () {
                              Get.back();
                              doctorsController.removeDoctorFromTopRated(
                                  listDoctor[index].id!);
                            });
                      },
                    ),
                  ),
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                doctorsController.selectedDoctor = listDoctor[index];
                Get.defaultDialog(
                    title: "Detail Doctor",
                    content: DetailDoctor(controller: doctorsController),
                    textCancel: 'Cancel',
                    textConfirm: 'Ok',
                    onConfirm: () {
                      Get.back();
                    });
              },
            ),
          ],
        ),
      )
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => listDoctor.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
