import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:militar_qr_code_generator/custom_text_field.dart';
import 'package:militar_qr_code_generator/qr_data_model.dart';
import 'package:militar_qr_code_generator/qr_image_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FormFillScreen extends StatefulWidget {
  FormFillScreen({super.key});
  final GlobalKey<FormState> Formkey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController nationalIdController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController collegeController = TextEditingController();
  final TextEditingController serialController = TextEditingController();

  @override
  State<FormFillScreen> createState() => _FormFillScreenState();
}

class _FormFillScreenState extends State<FormFillScreen> {
  String selectedCollege = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: add coleges as a list
      body: Form(
        key: widget.Formkey,
        child: SizedBox(
          height:
              PlatformDispatcher.instance.views.first.physicalSize.height /
              PlatformDispatcher.instance.views.first.devicePixelRatio,
          child: ListView(
            children: [
              SizedBox(height: 100),
              CustomTextField(
                controller: widget.usernameController,
                labelText: "الاسم رباعي",
                hintText: "الاسم رباعي",
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: widget.addressController,
                labelText: "العنوان",
                hintText: "العنوان",
                keyboardType: TextInputType.streetAddress,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: widget.nationalIdController,
                labelText: "الرقم القومي",
                hintText: "الرقم القومي",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: widget.phoneController,
                keyboardType: TextInputType.phone,
                labelText: "رقم الهاتف",
                hintText: "رقم الهاتف",
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: widget.serialController,
                labelText: "الرقم التسلسلي",
                keyboardType: TextInputType.number,
                hintText: "الرقم التسلسلي",
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: widget.collegeController,
                labelText: "الكليه",
                keyboardType: TextInputType.name,
                hintText: "الكليه",
              ),
              // Center(
              //   child: DropdownButton<String>(
              //     value: selectedCollege == "" ? "الكليه" : selectedCollege,
              //     items: widget.CollegeList,
              //     onChanged: (value) {
              //       setState(() {
              //         selectedCollege = value.toString().trim();
              //       });
              //     },
              //   ),
              // ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (widget.Formkey.currentState!.validate()) {
                      QrDataModel qrDataModel = QrDataModel(
                        student_name: widget.usernameController.text.trim(),
                        national_id: widget.nationalIdController.text.trim(),
                        serial_number: widget.serialController.text.trim(),
                        student_phone_number:
                            widget.phoneController.text.trim(),
                        faculty: widget.collegeController.text.trim(),
                        address: widget.addressController.text.trim(),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  QrImageScreen(s: qrDataModel.toString()),
                        ),
                      );
                    }
                  },
                  child: Text("انشاْ الكود"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
