part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.started() = _Started;
  const factory SearchEvent.searchedStudentEvent(String value) =
      SearchedStudentEvent;
  const factory SearchEvent.clearSearchEvent() = ClearSearchEvent;
  const factory SearchEvent.alldata() = Alldata;
}
