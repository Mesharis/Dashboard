import 'package:flutter/material.dart';
import 'package:hello_doctor_admin_dashboard/app/modules/doctors/controllers/doctors_controller.dart';
import 'package:hello_doctor_admin_dashboard/app/utils/timeformat.dart';

class DetailDoctor extends StatelessWidget {
  final DoctorsController controller;
  const DetailDoctor({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: 400,
            child: AspectRatio(
              aspectRatio: 1, // Maintain aspect ratio (1.0 means square)
              child: Image.network(
                controller.selectedDoctor!.doctorPicture!,
                // fit: BoxFit.scaleDown, // Preserve aspect ratio and fit inside
              ),
            ),
          ),
          const SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildKeyValueRow(
                  'Doctor Name', controller.selectedDoctor?.doctorName),
              _buildKeyValueRow('Doctor Specialty',
                  controller.selectedDoctor?.doctorCategory?.categoryName),
              _buildKeyValueRow(
                  'Biography', controller.selectedDoctor?.doctorShortBiography),
              _buildKeyValueRow(
                  'Hospital', controller.selectedDoctor?.doctorHospital),
              _buildKeyValueRow('Base Price',
                  controller.selectedDoctor?.doctorPrice.toString()),
              _buildKeyValueRow('Balance',
                  controller.selectedDoctor?.doctorBalance.toString()),
              _buildKeyValueRow(
                  'Account Status', controller.selectedDoctor?.accountStatus),
              _buildKeyValueRow(
                  'Created at',
                  TimeFormat()
                      .formatDate(controller.selectedDoctor?.createdAt)),
              _buildKeyValueRow(
                  'Last Update at',
                  TimeFormat()
                      .formatDate(controller.selectedDoctor?.updatedAt)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 150,
              child: Text('$key :',
                  style: TextStyle(fontWeight: FontWeight.bold))),
          SizedBox(width: 10),
          Expanded(child: Text(value ?? '')),
        ],
      ),
    );
  }
}
