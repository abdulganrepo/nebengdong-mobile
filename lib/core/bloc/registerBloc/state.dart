import 'package:equatable/equatable.dart';
import 'package:nebengdong/core/models/registerModel.dart';

class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterDisposeLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterModel value;
  RegisterSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class RegisterFailed extends RegisterState {}
