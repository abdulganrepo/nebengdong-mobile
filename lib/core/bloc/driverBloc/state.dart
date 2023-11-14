import 'package:equatable/equatable.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';

class DriverState extends Equatable {
  @override
  List<Object> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverDisposeLoading extends DriverState {}

class FindPassengerSuccessState extends DriverState {
  final ResponseNoDataModel value;
  FindPassengerSuccessState(this.value);

  @override
  List<Object> get props => [value];
}

class FindPassengerFailedState extends DriverState {}
