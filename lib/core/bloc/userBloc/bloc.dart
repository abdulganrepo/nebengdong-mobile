import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/userBloc/event.dart';
import 'package:nebengdong/core/bloc/userBloc/state.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/core/models/userModel.dart';
import 'package:nebengdong/core/services/userService.dart';
import 'package:nebengdong/utils/shared_prefferences_helper.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserService service;
  UserBloc(this.service) : super(UserInitial());
  UserState get initialState => UserInitial();

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUserProfileEvent) {
      yield UserLoading();
      print("Get User Profile Status");
      try {
        UserProfileModel value = await service.getUserProfile();
        yield UserDisposeLoading();
        yield GetUserProfileSuccess(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield UserDisposeLoading();
        yield GetUserProfileFailed();
      }
    }

    if (event is ChangePhoneNumberEvent) {
      yield UserLoading();
      print("Post Change Phone Number Status");
      try {
        ResponseNoDataModel value =
            await service.changePhoneNumber(event.phoneNumber);
        yield UserDisposeLoading();
        yield ChangePhoneNumberSuccess(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield UserDisposeLoading();
        yield ChangePhoneNumberFailed();
      }
    }

    if (event is ChangePasswordEvent) {
      yield UserLoading();
      print("Post Change Password Status");
      try {
        ResponseNoDataModel value =
            await service.changePassword(event.oldPass, event.newPass);
        yield UserDisposeLoading();
        yield ChangePasswordSuccess(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield UserDisposeLoading();
        yield ChangePasswordFailed();
      }
    }
  }
}
