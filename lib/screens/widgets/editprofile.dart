import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app_hive/application/student/student_bloc.dart';
import 'package:student_app_hive/db/model/data_model.dart';
import 'package:iconsax/iconsax.dart';
import '../home_screen.dart';
class EditProfile extends StatefulWidget {
  EditProfile(
      {Key? key,
      // required this.passValue01,
      required this.index,
      required this.passValueProfile})
      : super(key: key);

  StudentModel passValueProfile;
  int index;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final _nameController =
      TextEditingController(text: widget.passValueProfile.name);

  late final _ageController =
      TextEditingController(text: widget.passValueProfile.age);

  late final _numController =
      TextEditingController(text: widget.passValueProfile.num);

  String? imagePath;
  String selectedImagePath = '';
  // final ImagePicker _picker = ImagePicker();

//function or widget==================================================

  // ignore: non_constant_identifier_names
  Future<void> StudentAddBtn(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numController.text.trim();
    // final _image = imagePath;

    // if (_name.isEmpty || _age.isEmpty || _number.isEmpty) {
    //   return;
    // }
    print('$_name $_age $_number');

    // final _students = StudentModel(
    //   name: _name,
    //   age: _age,
    //   num: _number,
    //   image: imagePath ?? widget.passValueProfile.image,
    // );
    // final studentDB = await Hive.openBox<StudentModel>('student_db');
    // studentDB.putAt(index, _students);
    // getAllStudents();
    // updateNew(_students, index);
    //getAllStudents();
    // deleteStudent(index);
  }

  Widget elavatedbtn() {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<StudentBloc>().add(
            UpdateSpecificstudentData(widget.passValueProfile, widget.index));

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const Home_Screen()),
            (route) => false);
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, required String hintName}) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(234, 236, 238, 2),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
          icon: Icon(Iconsax.user)
          // hintText: hintName,
          ),
      // initialValue: 'hintName',
    );
  }

  Widget textFieldAge(
      {required TextEditingController myController, required String hintName}) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(234, 236, 238, 2),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
          icon: Icon(Iconsax.calendar)
          // hintText: hintName,

          ),
      keyboardType: TextInputType.number,
      // initialValue: 'hintName',
    );
  }

  Widget textFieldNum(
      {required TextEditingController myController, required String hintName}) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(234, 236, 238, 2),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)),
          icon: Icon(Iconsax.mobile)
          // hintText: hintName,
          ),
      keyboardType: TextInputType.number,
      // initialValue: 'hintName',
    );
  }

  Widget dpImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: selectedImagePath == ''
              ? FileImage(File(widget.passValueProfile.image))
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

  //build======================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(
                  myController: _nameController,
                  hintName: widget.passValueProfile.name),
              szdBox,
              textFieldAge(
                  myController: _ageController,
                  hintName: widget.passValueProfile.age),
              szdBox,
              textFieldNum(
                  myController: _numController,
                  hintName: widget.passValueProfile.num),
              szdBox,
              elavatedbtn(),
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
                                      'assets/images/camera.png',
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
                                      'assets/images/gallery.png',
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
