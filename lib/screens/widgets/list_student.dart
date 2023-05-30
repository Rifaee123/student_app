import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:student_app_hive/application/student/student_bloc.dart';
import 'package:student_app_hive/db/functions/db_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:student_app_hive/screens/profile_screen.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is Initial) {
          context.read<StudentBloc>().add(FetchAllData());
        }
        if (state is DisplayAllStudents) {
          if (state.students.isNotEmpty) {
            return ListView.separated(
              itemBuilder: ((ctx, index) {
                return ListTile(
                  // onTap: Navigator,
                  leading: CircleAvatar(
                    backgroundImage:
                        FileImage(File(state.students[index].image), scale: 4),
                    radius: 30,
                  ),
                  title: Text(state.students[index].name),
                  subtitle: Text(state.students[index].age),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage(
                                  passId: index,
                                  passValue: state.students[index],
                                )));
                  }),

                  trailing: IconButton(
                      onPressed: () {
                       
                        deleteAlert(context, index,state.students);
                        //deleteStudent(index);
                      },
                      icon: Icon(
                        Iconsax.user_remove,
                        color: Colors.red,
                      )),
                );
              }),
              separatorBuilder: (ctx, index) {
                return Divider();
              },
              itemCount: state.students.length,
            );
          }
        }
        return const Center(
          child: Text("List is Empty"),
        );
      },
    );
  }
}

deleteAlert(BuildContext context, index,students) {
  showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('Are you sure you want to delete'),
            actions: [
              TextButton(
                  onPressed: () {
                     context
                        .read<StudentBloc>()
                        .add(DeleteSpecificstudentData(students, index));
                    // deleteStudent(index);
                    Navigator.of(context).pop(ctx);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )));
}
