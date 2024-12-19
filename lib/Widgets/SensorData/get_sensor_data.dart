import 'package:advnet/Widgets/SensorData/bloc/sensor_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class GetSensorData extends StatelessWidget {
  const GetSensorData({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.green,
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: 100,
          minHeight: 0,
          maxHeight: 100,
        ),
        child: BlocBuilder<SensorDataCubit, dynamic>(
          builder: (BuildContext context, state) {
            return Text("Sensor Distance: $state");
          },
        ),
      ),
    );
  }
}
