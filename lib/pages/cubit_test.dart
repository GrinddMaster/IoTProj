import 'package:bloc/bloc.dart';

class Countercubti extends Cubit {
  Countercubti(super.initialState);
  void increment() => emit(state + 1);
}
