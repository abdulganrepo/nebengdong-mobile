import 'package:equatable/equatable.dart';

class PassengerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FindDriverEvent extends PassengerEvent {
  final double lat;
  final double long;

  FindDriverEvent(this.lat, this.long);

  @override
  // TODO: implement props
  List<Object> get props => [lat, long];
}

class ActiveShareRidePassengerEvent extends PassengerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
