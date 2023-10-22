import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/loginBloc/event.dart';
import 'package:nebengdong/core/bloc/loginBloc/state.dart';
import 'package:nebengdong/core/models/loginModel.dart';
import 'package:nebengdong/core/services/loginService.dart';
import 'package:nebengdong/utils/shared_prefferences_helper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginService service;
  LoginBloc(this.service) : super(LoginInitial());
  LoginState get initialState => LoginInitial();

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserEvent) {
      yield LoginLoading();
      print("Login User Status");
      try {
        LoginModel value = await service.loginUser(event.email, event.password);
        yield LoginDisposeLoading();
        SharedPrefs.setToken(value.data!.token!.value);
        yield LoginSuccess(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield LoginDisposeLoading();
        yield LoginFailed();
      }
    }
  }
}
