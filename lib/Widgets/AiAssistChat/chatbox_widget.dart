import 'package:advnet/Widgets/Voice_chat/voice_chat_widget.dart';
import 'package:advnet/pages/mqtt_client.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:advnet/Widgets/AiAssistChat/bloc/chatbox_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:advnet/Widgets/Voice_chat/bloc/voicechat_cubit.dart';

int state = 0;
FlutterTts tts = FlutterTts();

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
                    voiceCommand(state.response);
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
                    decoration: InputDecoration(hintText: "Chat !"),
                    controller: _controller,
                  ),
                ),
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    context.read<AiCubit>().sendText(
                      _controller.text.toString(),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocProvider<VoicechatCubit>(
                  create: (BuildContext context) => VoicechatCubit(),
                  child: VoiceChatWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> voiceCommand(String response) async {
  await tts.speak(response);
  if (response.contains("level 1") || response.contains("Level 1")) {
    motorDriver("level1");
  } else if (response.contains("level 2") || response.contains("Level 2")) {
    motorDriver("level2");
  } else if (response.contains("level 3") || response.contains("Level 3")) {
    motorDriver("level3");
  }
}

Future<void> initalizeTts() async {
  await tts.isLanguageAvailable("en-US");
  await tts.getDefaultVoice;
  await tts.setVolume(1.0);
  await tts.setPitch(1.0);
  await tts.setSpeechRate(1.0);
  await tts.awaitSpeakCompletion(true);
  await tts.awaitSynthCompletion(true);
}
