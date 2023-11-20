import 'package:equatable/equatable.dart';
import 'package:nebengdong/core/models/getShareRideByPassengerModel.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';

class PassengerState extends Equatable {
  @override
  List<Object> get props => [];
}

class PassengerInitial extends PassengerState {}

class PassengerLoading extends PassengerState {}

class PassengerDisposeLoading extends PassengerState {}

class FindDriverSuccessState extends PassengerState {
  final ResponseNoDataModel value;
  FindDriverSuccessState(this.value);

  @override
  List<Object> get props => [value];
}

class FindDriverFailedState extends PassengerState {}

class ActiveShareDrivePassengerSuccess extends PassengerState {
  final GetShareRideByPassengerModel value;
  ActiveShareDrivePassengerSuccess(this.value);

  @override
  List<Object> get props => [value];
}

class ActiveShareDrivePassengerFailed extends PassengerState {}
