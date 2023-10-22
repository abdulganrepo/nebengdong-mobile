import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterDisposeLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final value;
  RegisterSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class RegisterFailed extends RegisterState {}
