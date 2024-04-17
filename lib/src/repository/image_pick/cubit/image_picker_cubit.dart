import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePicker picker = ImagePicker();

  firebase_storage.FirebaseStorage myStorage =
      firebase_storage.FirebaseStorage.instance;

  ImagePickerCubit() : super(ImagePickerInitial());

  Future pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      emit(ImagePickerState(myFile: File(pickedFile.path)));
    } else {
      print('no file selected');
    }
  }

  Future uploadImage(File? file) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref();
    firebase_storage.UploadTask uploadTask = ref.putFile(file!.absolute);
     
  }
}
