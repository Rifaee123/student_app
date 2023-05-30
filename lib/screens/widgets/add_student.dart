import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:student_app_hive/application/student/student_bloc.dart';
import 'package:student_app_hive/db/model/data_model.dart';
import '../../db/functions/db_functions.dart';
import 'package:iconsax/iconsax.dart';

class AddStudent_w extends StatefulWidget {
  AddStudent_w({super.key});

  @override
  State<AddStudent_w> createState() => _AddStudent_wState();
}

class _AddStudent_wState extends State<AddStudent_w> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numController = TextEditingController();
  String? imagePath;
  String selectedImagePath = '';

  Future<void> onAddStudentButtonClick(BuildContext ctx) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _num = _numController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _num.isEmpty) {
      return;
    }
    print('$_name $_age $_num');
    // } else {
    //   Navigator.of(ctx).push(MaterialPageRoute(builder:((context) =>Home_Screen() )));
    // }
    // print('$_name $_age');

    final _student = StudentModel(
      name: _name,
      age: _age,
      num: _num,
      image: imagePath!,
    );

    // addStudent(_student);
  }

  Future<void> takePhoto() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (PickedFile != null) {
      setState(() {
        imagePath = PickedFile.path;
        imagePath == null
            ? AssetImage('assets/pp3.jpg') as ImageProvider
            : FileImage(File(imagePath!));
      });
    }
  }

  Widget elavatedbtn({required Icon myIcon, required Text myLabel}) {
    return ElevatedButton.icon(
      onPressed: () {
        if (imagePath != null ||
            _nameController != null ||
            _numController != null ||
            _ageController != null) {
          BlocProvider.of<StudentBloc>(context).add(
            AddStudentData(
              StudentModel(
                  name: _nameController.text,
                  age: _ageController.text,
                  num: _numController.text,
                  image: selectedImagePath),
            ),
          );

          Navigator.of(context).pop();
          // }
        }
      },
      icon: myIcon,
      label: myLabel,
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, hintName}) {
    return TextFormField(
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        icon: Icon(Icons.person),
        hintText: hintName,
      ),
    );
  }

  Widget textFieldAge({required TextEditingController myController, hintName}) {
    return TextFormField(
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        icon: Icon(Icons.date_range),
        hintText: hintName,
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget textFieldNum({required TextEditingController myController, hintName}) {
    return TextFormField(
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        icon: Icon(Icons.phone_android_rounded),
        hintText: hintName,
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: selectedImagePath == ''
              ? NetworkImage(
                      'https://tse4.explicit.bing.net/th?id=OIP.audMX4ZGbvT2_GJTx2c4GgHaHw&pid=Api&P=0&h=180')
                  as ImageProvider
              : FileImage(File(selectedImagePath)),
        ),
        Positioned(
            bottom: 0,
            right: 25,
            child: CircleAvatar(
              backgroundColor: Colors.lime,
              child: InkWell(
                  child: const Icon(
                    Iconsax.camera,
                    size: 30,
                    color: Colors.black,
                  ),
                  onTap: () {
                    selectImage();
                  }),
            )),
      ],
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  //buider------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Student'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(myController: _nameController, hintName: "Name"),
              szdBox,
              textFieldAge(myController: _ageController, hintName: "Age"),
              szdBox,
              textFieldNum(myController: _numController, hintName: "Number"),
              szdBox,
              elavatedbtn(
                  myIcon: const Icon(Iconsax.user_add),
                  myLabel: const Text(
                    'Add student',
                  )),
              // elavatedbtn(
              //     myIcon: Icon(Icons.access_alarm), myLabel: 'saample2'),
            ]),
          ),
        ));
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
