part of 'image_picker_cubit.dart';

 class ImagePickerState extends Equatable {
  final File? myFile;
   ImagePickerState({this.myFile});

  @override
  List<Object> get props => [myFile!];
}

final class ImagePickerInitial extends ImagePickerState {}
