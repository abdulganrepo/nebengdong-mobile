import 'package:equatable/equatable.dart';
import 'package:nebengdong/core/services/registerService.dart';

class UserEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangePhoneNumberEvent extends UserEvent {
  final String phoneNumber;
  ChangePhoneNumberEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class ChangePasswordEvent extends UserEvent {
  final String oldPass;
  final String newPass;
  ChangePasswordEvent(this.oldPass, this.newPass);

  @override
  List<Object> get props => [oldPass, newPass];
}
