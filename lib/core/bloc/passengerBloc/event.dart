import 'package:equatable/equatable.dart';

class PassengerEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FindDriverEvent extends PassengerEvent {
  final double lat;
  final double long;
  final double distance;
  final int totalAmount;

  FindDriverEvent(this.lat, this.long, this.distance, this.totalAmount);

  @override
  // TODO: implement props
  List<Object> get props => [lat, long];
}

class ActiveShareRidePassengerEvent extends PassengerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
