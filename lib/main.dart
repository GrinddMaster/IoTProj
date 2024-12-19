import 'package:flutter/material.dart';
import 'package:advnet/pages/mqtt_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:advnet/pages/speed_picker.dart';

class CountObserver extends BlocObserver {
  const CountObserver();
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }
}

class Home extends MaterialApp {
  const Home({super.key})
    : super(home: const SpeedPicker(), debugShowCheckedModeBanner: false);
}

void main() {
  Bloc.observer = const CountObserver();
  //startClient();
  runApp(Home());
}
