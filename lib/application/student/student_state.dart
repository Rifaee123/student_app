part of 'student_bloc.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = Initial;
   factory StudentState.displayAllStudents(List<StudentModel> students) =
      DisplayAllStudents;
 
  factory StudentState.displaySpecificData(StudentModel student) =
      DisplaySpecificData;
}
