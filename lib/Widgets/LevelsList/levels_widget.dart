import 'package:advnet/pages/ai_assist_page.dart';
import 'package:flutter/material.dart';
import 'package:advnet/pages/mqtt_client.dart';
import 'package:advnet/Widgets/LevelsList/bloc/levels_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

//TODO: onChange should call the publish message functoin
//TODO: send the value to the publish function.
int bandwidth = 0;

class LevelsWidget extends StatelessWidget {
  const LevelsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          "Cool 🥶 App",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: [
              BlocBuilder<SliderCubit, double>(
                builder: (context, state) {
                  return SfSlider.vertical(
                    min: 0,
                    max: 3,
                    value: state,
                    interval: 1,
                    showTicks: true,
                    showLabels: true,
                    minorTicksPerInterval: 1,
                    onChanged: (value) {
                      context.read<SliderCubit>().emitValue(value);
                      speedLevelPicker(value);
                    },
                  );
                },
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Column(
                  children: [
                    Row(children: [Text("level 3 -> 24C <<")]),
                    Divider(),
                    Row(children: [Text("level 2 -> 22C - 24C")]),
                    Divider(),
                    Row(children: [Text("level 1 -> 20C - 22C ")]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.radio_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AiAssistPage(),
            ),
          );
        },
      ),
    );
  }
}

void speedLevelPicker(double value) {
  if (value < 1.0 && value >= 0.0 && bandwidth == 0) {
    motorDriver("level0");
    bandwidth = 1; //Limits signals sent to broker
  } else if (value >= 1.0 && value < 2.0) {
    bandwidth = 0;
    motorDriver("level1");
  } else {
    bandwidth = 0;
    (value > 2.0 && value <= 2.5)
        ? motorDriver("level2")
        : motorDriver("level3");
  }
}
