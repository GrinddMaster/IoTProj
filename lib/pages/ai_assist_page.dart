import 'package:advnet/Widgets/AiAssistChat/bloc/chatbox_bloc.dart';
import 'package:advnet/Widgets/AiAssistChat/chatbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiAssistPageBlocProvider extends StatelessWidget {
  const AiAssistPageBlocProvider({super.key});

  @override
  BlocProvider<AiCubit> build(BuildContext context) {
    return BlocProvider<AiCubit>(
      create: (BuildContext context) => AiCubit(),
      child: ChatBoxWidget(),
    );
  }
}

class AiAssistPage extends StatelessWidget {
  const AiAssistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blueAccent,
        title: Text("Ai Assistant 🤖"),
      ),
      body: AiAssistPageBlocProvider(),
    );
  }
}
