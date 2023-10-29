import 'package:equatable/equatable.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/core/models/userModel.dart';

class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserDisposeLoading extends UserState {}

class GetUserProfileSuccess extends UserState {
  final UserProfileModel value;
  GetUserProfileSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class GetUserProfileFailed extends UserState {}

class ChangePhoneNumberSuccess extends UserState {
  final ResponseNoDataModel value;
  ChangePhoneNumberSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class ChangePhoneNumberFailed extends UserState {}

class ChangePasswordSuccess extends UserState {
  final ResponseNoDataModel value;
  ChangePasswordSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class ChangePasswordFailed extends UserState {}
