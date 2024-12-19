import 'package:flutter/material.dart';
import 'package:advnet/Widgets/AiAssistChat/bloc/chatbox_bloc.dart';

class ChatBoxWidget extends StatelessWidget {
  const ChatBoxWidget({super.key});

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
              child: Text("Varaiable result from Cubit"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(hintText: "Prompt"),
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
