import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebengdong/core/bloc/passengerBloc/event.dart';
import 'package:nebengdong/core/bloc/passengerBloc/state.dart';
import 'package:nebengdong/core/models/responseNoDataModel.dart';
import 'package:nebengdong/core/services/passangerService.dart';

class PassengerBloc extends Bloc<PassengerEvent, PassengerState> {
  PassengerService service;
  PassengerBloc(this.service) : super(PassengerInitial());
  PassengerState get initialState => PassengerInitial();

  Stream<PassengerState> mapEventToState(PassengerEvent event) async* {
    if (event is FindDriverEvent) {
      yield PassengerLoading();
      try {
        ResponseNoDataModel value = await service.findDriver();
        yield PassengerDisposeLoading();
        yield FindDriverSuccessState(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield PassengerDisposeLoading();
        yield FindDriverFailedState();
      }
    }
  }
}
