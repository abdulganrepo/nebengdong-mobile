import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/driverBloc/event.dart';
import 'package:nebengdong/core/bloc/driverBloc/state.dart';
import 'package:nebengdong/core/models/getActiveShareRideByDriverModel.dart';
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
        ResponseNoDataModel value = await service.findPassenger();
        yield DriverDisposeLoading();
        yield FindPassengerSuccessState(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield DriverDisposeLoading();
        yield FindPassengerFailedState();
      }
    }

    if (event is GetPassengerEvent) {
      yield DriverLoading();
      try {
        GetActiveShareRideByDriverModel value = await service.getPassenger();
        yield DriverDisposeLoading();
        yield GetPassengerSuccessState(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield DriverDisposeLoading();
        yield GetPassengerFailedState();
      }
    }

    if (event is UpdatePassengerStatusEvent) {
      yield DriverLoading();
      try {
        ResponseNoDataModel value = await service.updateShareRide(
            event.shareRideId, event.passengerId, event.status);
        yield DriverDisposeLoading();
        yield UpdatePassengerStatusSuccessState(value);
        print("sukses bloc nya");
      } catch (e, stackTrace) {
        print("Error : ${e.toString()}");
        print("Error ST : ${stackTrace.toString()}");
        yield DriverDisposeLoading();
        yield UpdatePassengerStatusFailedState();
      }
    }
  }
}
