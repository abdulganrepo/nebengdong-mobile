import 'package:equatable/equatable.dart';

class DriverEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FindPassengerEvent extends DriverEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetPassengerEvent extends DriverEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdatePassengerStatusEvent extends DriverEvent {
  final int shareRideId;
  final int passengerId;
  final int status;

  UpdatePassengerStatusEvent(this.shareRideId, this.passengerId, this.status);
  @override
  // TODO: implement props
  List<Object> get props => [shareRideId, passengerId, status];
}
