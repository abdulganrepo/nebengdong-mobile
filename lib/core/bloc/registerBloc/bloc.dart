import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/registerBloc/event.dart';
import 'package:nebengdong/core/bloc/registerBloc/state.dart';
import 'package:nebengdong/core/models/registerModel.dart';
import 'package:nebengdong/core/services/registerService.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterService service;
  RegisterBloc(this.service) : super(RegisterInitial());
  RegisterState get initialState => RegisterInitial();

  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is AddNewUserEvent) {
      yield RegisterLoading();
      print("Add New User Status");
      try {
        RegisterModel value = await service.addNewUser(event.data);
        yield RegisterDisposeLoading();
        yield RegisterSuccess(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield RegisterDisposeLoading();
        yield RegisterFailed();
      }
    }
  }
}
