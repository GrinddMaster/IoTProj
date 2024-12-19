import 'package:bloc/bloc.dart';

//TODO: emit the new value of the slider.
class SliderCubit extends Cubit<double> {
  SliderCubit() : super(0.0);
  void emitValue(double value) {
    emit(value);
  }
}
