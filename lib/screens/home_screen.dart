import 'package:flutter/services.dart';
// import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_app_hive/db/functions/db_functions.dart';
import 'package:student_app_hive/screens/search.dart';
import 'package:student_app_hive/screens/widgets/add_student.dart';
import 'package:student_app_hive/screens/widgets/list_student.dart';
import 'package:iconsax/iconsax.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          icon: Icon(Iconsax.arrow_left),
        ),
        title: Text(
          'Student List',
          style:
              GoogleFonts.robotoMono(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => SearchScreen())));
              },
              icon: Icon(Iconsax.search_normal)),
        ],
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StudentList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Iconsax.add),
        onPressed: () {
          add(context);
        },
      ),
    );
  }

  add(BuildContext ctx) {
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (ctx1) => AddStudent_w()));
  }
}
