import 'package:flutter/material.dart';
import 'package:advnet/Widgets/AiAssistChat/bloc/chatbox_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBoxWidget extends StatelessWidget {
  ChatBoxWidget({super.key});
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 400,
              color: Colors.red,
              height: 500,
              child: BlocBuilder<AiCubit, AiState>(
                builder: (context, state) {
                  if (state is AiInitState) {
                    return Text('Waiting response...');
                  } else if (state is AiError) {
                    return Text("Error Occured! ${state.error}");
                  } else if (state is AiResponse) {
                    return Text(state.response);
                  }
                  return Text("Exception occured?");
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(hintText: "Prompt"),
                    controller: _controller,
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    context.read<AiCubit>().sendText(_controller.text);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
