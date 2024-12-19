import 'package:bloc/bloc.dart';
import 'package:advnet/Widgets/get_values.dart';

class SensorDataCubit extends Cubit {
  SensorDataCubit(super.initialState);

  void showData() => emit(fetchData());
  //I think this should emit the new data that's coming from the function.
}
