import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'photo_state.dart';

// PhotoCubit implementation
class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoState.initial());

  Future<void> uploadPhoto(File photo) async {
    emit(state.copyWith(status: PhotoStatus.loading));
    try {
      final String fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('profile_photos/$fileName');

      final UploadTask uploadTask = firebaseStorageRef.putFile(photo);
      final TaskSnapshot taskSnapshot = await uploadTask;

      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      emit(state.copyWith(status: PhotoStatus.success, photoUrl: downloadUrl));
    } catch (e) {
      emit(state.copyWith(status: PhotoStatus.failure, error: e.toString()));
    }
  }
}
