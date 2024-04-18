import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePicker picker = ImagePicker();

  firebase_storage.FirebaseStorage myStorage =
      firebase_storage.FirebaseStorage.instance;

  ImagePickerCubit() : super(ImagePickerInitial());

  Future pickImage() async {
    try {
      final pickedFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
      if (pickedFile != null) {
        emit(ImagePickerState(myFile: File(pickedFile.path)));
      } else {
        print('no file selected');
      }
    } on Exception catch (e) {
      return e;
    }
  }

  Future uploadImage(File? file) async {
    String filename = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      Reference reference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('/foods/$filename');

      await reference.putFile(file!.absolute);
      String downloadUrl = await reference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return '';
    }
    // firebase_storage.Reference ref =
    //     firebase_storage.FirebaseStorage.instance.ref('/myfolder' '+' '1234');
    // firebase_storage.UploadTask uploadTask = ref.putFile(file!.absolute);
    // await Future.value(uploadTask);
  }
}
