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

  //final TextEditingController nameController = TextEditingController();
  final TextEditingController serialController = TextEditingController();

  final List<DropdownMenuItem<String>> CollegeList = [
    DropdownMenuItem(child: Text("الكليه"), value: "الكليه"),
    DropdownMenuItem(child: Text("العلوم"), value: "العلوم"),
  ];

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
              SizedBox(height: 10),
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
              DropdownButton<String>(
                value: selectedCollege == "" ? "الكليه" : selectedCollege,
                items: widget.CollegeList,
                onChanged: (value) {
                  setState(() {
                    selectedCollege = value.toString().trim();
                  });
                },
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (selectedCollege == "" || selectedCollege == "الكليه") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("برجاء اختيار الكلية")),
                      );
                    } else {
                      if (widget.Formkey.currentState!.validate()) {
                        QrDataModel qrDataModel = QrDataModel(
                          student_name: widget.usernameController.text,
                          national_id: widget.nationalIdController.text,
                          serial_number: widget.serialController.text,
                          student_phone_number: widget.phoneController.text,
                          faculty: selectedCollege,
                          address: widget.addressController.text,
                        );
                        //                         QrImageView(
                        //   data: '1234567890',
                        //   version: QrVersions.auto,
                        //   size: 200.0,
                        // ),
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    QrImageScreen(s: qrDataModel.toString()),
                          ),
                        );
                      }
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
