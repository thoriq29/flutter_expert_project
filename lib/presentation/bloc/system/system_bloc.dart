import 'dart:async';
 
import 'package:bloc/bloc.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';
 
part 'system_event.dart';
part 'system_state.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  SystemBloc() : super(SystemState());
 
  @override
  Stream<SystemState> mapEventToState(
    SystemEvent event,
  ) async* {
    if (event is SetActiveMenu) {
      yield SelectedMenuState(event._menuState);
    }
  }
}