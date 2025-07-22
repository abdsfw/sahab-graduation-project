part of 'select_photo_cubit.dart';

sealed class SelectPhotoState {}

final class SelectPhotoInitial extends SelectPhotoState {}

final class DeleteSelectPhotoState extends SelectPhotoState {}

final class AddSelectPhotoState extends SelectPhotoState {}

// final class AddSelectPhotoOddState extends SelectPhotoState {}

final class SelectDeleteModePhotoState extends SelectPhotoState {}
