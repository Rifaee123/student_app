import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_app_hive/db/functions/db_functions.dart';

import '../../db/model/data_model.dart';

part 'student_event.dart';
part 'student_state.dart';
part 'student_bloc.freezed.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
   StudentBloc() : super(const StudentState.initial()) {
    on<FetchAllData>((event, emit) {
      try {
        final studentdata = StudentBox.getStudentData();
        List<StudentModel> students = studentdata.values.toList();
        emit(StudentState.displayAllStudents(students));
      } catch (e) {
        log(e.toString());
      }
    });

    on<AddStudentData>((event, emit) {
      try {
        final studentBox = StudentBox.getStudentData();
        studentBox.add(event.studentdata);
        add(FetchAllData());
      } catch (e) {
        log(e.toString());
      }
    });

    on<UpdateSpecificstudentData>((event, emit) {
      try {
        final studentData = StudentBox.getStudentData();
        studentData.putAt(event.index, event.studentModel);
        add(FetchAllData());
      } catch (e) {
        log(e.toString());
      }
    });
    on<DeleteSpecificstudentData>((event, emit) {
      final studentDeletData = StudentBox.getStudentData();
      try {
        studentDeletData.deleteAt(event.index);
        add(FetchAllData());
      } catch (e) {
        log(e.toString());
      }
    });

  }
}
