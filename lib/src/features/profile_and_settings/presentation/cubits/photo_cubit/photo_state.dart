part of 'photo_cubit.dart';

// PhotoState
class PhotoState {
  final PhotoStatus status;
  final String? photoUrl;
  final String? error;

  PhotoState({required this.status, this.photoUrl, this.error});

  factory PhotoState.initial() => PhotoState(status: PhotoStatus.initial);

  PhotoState copyWith({
    PhotoStatus? status,
    String? photoUrl,
    String? error,
  }) {
    return PhotoState(
      status: status ?? this.status,
      photoUrl: photoUrl ?? this.photoUrl,
      error: error ?? this.error,
    );
  }
}

enum PhotoStatus { initial, loading, success, failure }
