part of 'student_bloc.dart';

@freezed
class StudentEvent with _$StudentEvent {
  factory StudentEvent.fetchAllData() = FetchAllData;

  const factory StudentEvent.addStudentData(StudentModel studentdata) = AddStudentData;

  factory StudentEvent.fetchSpecificData() = FetchSpecificData; 

  factory StudentEvent.updateSpecificstudentData(StudentModel studentModel, int index) = UpdateSpecificstudentData;

  factory StudentEvent.deleteSpecificstudentData(List<StudentModel> studentModel, int index) = DeleteSpecificstudentData;

}