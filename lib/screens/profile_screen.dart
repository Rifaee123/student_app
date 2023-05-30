import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_app_hive/db/model/data_model.dart';
import 'package:student_app_hive/screens/widgets/editprofile.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key, required this.passId, required this.passValue});

  StudentModel passValue;
  final int passId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        primary: false,
        backgroundColor: Colors.blueGrey[400],
        elevation: 0,
      ),
      floatingActionButton: floatbtn(context),
      body: Container(
        decoration: BoxDecoration(color: Colors.blueGrey[400]),
        child: ListView(
          children: <Widget>[
            profileImage(),
            SizedBox(
              height: 10,
            ),
            content(),
          ],
        ),
      ),
    ));
  }

  Widget profileImage() => Padding(
        padding: const EdgeInsets.only(top: 100),
        child: CircleAvatar(
          backgroundImage: FileImage(File(passValue.image), ),
          radius: 100,
        ),
      );
  Widget floatbtn(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfile(
                        passValueProfile: passValue,
                        index: passId,
                      )));
        },
        child: const Icon(Icons.edit_outlined));
  }

  Widget content() {
    return Container(
      width: 200,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ' ${passValue.name}',
            style: GoogleFonts.lato(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              height: 40,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text('Age : ${passValue.age}',
                    style: GoogleFonts.mukta(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            height: 40,
            width: 300,
            child: Center(
              child: Text('Number : ${passValue.num}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}
