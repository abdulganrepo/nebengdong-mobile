import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/DriverBloc/event.dart';
import 'package:nebengdong/core/bloc/DriverBloc/state.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/core/services/driverService.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  DriverService service;
  DriverBloc(this.service) : super(DriverInitial());
  DriverState get initialState => DriverInitial();

  Stream<DriverState> mapEventToState(DriverEvent event) async* {
    if (event is FindPassengerEvent) {
      yield DriverLoading();
      try {
        ResponseNoDataModel value = await service.findPassengerApi();
        yield DriverDisposeLoading();
        yield FindPassengerSuccessState(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield DriverDisposeLoading();
        yield FindPassengerFailedState();
      }
    }
  }
}
