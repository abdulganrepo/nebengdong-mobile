import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginDisposeLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final value;
  LoginSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class LoginFailed extends LoginState {}
