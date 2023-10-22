import 'package:equatable/equatable.dart';
import 'package:nebengdong/core/services/registerService.dart';

class RegisterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddNewUserEvent extends RegisterEvent {
  final RegisterPost data;

  AddNewUserEvent(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}
