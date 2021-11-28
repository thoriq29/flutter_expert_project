part of 'system_bloc.dart';

abstract class SystemEvent extends Equatable {
  const SystemEvent();
 
  @override
  List<Object> get props => [];
}
 
class SetActiveMenu extends SystemEvent {
  final MenuState _menuState;

  SetActiveMenu(this._menuState);

  @override
  List<Object> get props => [_menuState];
}
 