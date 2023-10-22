import 'package:equatable/equatable.dart';
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
