import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_app_hive/screens/profile.dart';
import 'package:iconsax/iconsax.dart';

import '../application/search/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  // List<StudentModel> studentList =
  //     Hive.box<StudentModel>('student_db').values.toList();

  // late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);

//function or widgets-------------------------------------------------------

  Widget expanded() {
    return Expanded(child: BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const Center(
            child: Text('Search somthing'),
          );
        } else if (state is Loaded) {
          return ListView.builder(
            itemCount: state.student.length,
            itemBuilder: (context, index) {
              // final data = studentList[index];
              File img = File(state.student[index].image);
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(img),
                  // studentDisplay[index].image.toString(),
                  radius: 22,
                ),
                title: Text(state.student[index].name),
                // subtitle: Text(
                //     '${studentDisplay[index]["age"].toString()} years old'),
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentProfile(
                                passValue: state.student[index],
                                passId: state.student[index].id!,
                              )));
                }),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }

  Widget searchTextField() {
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(Iconsax.search_normal),
        suffixIcon: IconButton(
          icon: const Icon(Iconsax.close_circle),
          onPressed: () => clearText(),
        ),
        filled: true,
        fillColor: const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: 'search',
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          BlocProvider.of<SearchBloc>(context).add(const ClearSearchEvent());
        }
        BlocProvider.of<SearchBloc>(context).add(SearchedStudentEvent(value));
        // _searchStudent(value);
        log(value.toString());
      },
    );
  }

  // void _searchStudent(String value) {
  //   setState(() {
  //     studentDisplay = studentList
  //         .where((element) =>
  //             element.name.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  void clearText() {
    _searchController.clear();
  }

  //builder-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(),
              SizedBox(
                height: 10,
              ),
              expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
