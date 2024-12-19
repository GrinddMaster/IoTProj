import 'package:advnet/Widgets/LevelsList/bloc/levels_bloc.dart';
import 'package:flutter/material.dart';
import 'package:advnet/Widgets/LevelsList/levels_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
   TODO: This should have a widget that display the speed levels.
  TODO: When user chooses a level send a
  message to the borker of the level chosen.
   */

class SpeedPicker extends StatelessWidget {
  const SpeedPicker({super.key});

  @override
  BlocProvider<SliderCubit> build(BuildContext context) {
    return BlocProvider<SliderCubit>(
      create: (BuildContext context) => SliderCubit(),
      child: LevelsWidget(),
    );
  }
}
