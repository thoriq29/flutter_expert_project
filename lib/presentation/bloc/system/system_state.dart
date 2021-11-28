part of "system_bloc.dart";
 
class SystemState extends Equatable {
  const SystemState();

  @override
  List<Object> get props => [];
}

class SelectedMenuState extends SystemState {
  MenuState menuState = MenuState.Movie;

  SelectedMenuState(this.menuState);

  @override
  List<Object> get props => [menuState];
}