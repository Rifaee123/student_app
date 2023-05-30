import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_app_hive/db/model/data_model.dart';
import '../../db/functions/db_functions.dart';
part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchedStudentEvent>((event, emit) {
      try {
        final student = StudentBox.getStudentData();

        List<StudentModel> studentSerchList = student.values.toList();
        studentSerchList = studentSerchList
            .where((element) =>
                element.name.toLowerCase().contains(event.value.toLowerCase()))
            .toList();
        emit(SearchState.loaded(studentSerchList));
      } catch (e) {
        log(e.toString());
      }
    });
    on<ClearSearchEvent>((event, emit) {
      emit(const SearchInitial());
    });
  }
}
