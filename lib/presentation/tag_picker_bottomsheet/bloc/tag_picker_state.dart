// ignore_for_file: must_be_immutable

part of 'tag_picker_bloc.dart';

/// Represents the state of TagPicker in the application.
class TagPickerState extends Equatable {
  TagPickerState({this.tagPickerModelObj});

  TagPickerModel? tagPickerModelObj;

  @override
  List<Object?> get props => [
        tagPickerModelObj,
      ];
  TagPickerState copyWith({TagPickerModel? tagPickerModelObj}) {
    return TagPickerState(
      tagPickerModelObj: tagPickerModelObj ?? this.tagPickerModelObj,
    );
  }
}
