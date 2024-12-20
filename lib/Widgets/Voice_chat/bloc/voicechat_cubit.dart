import 'package:advnet/Widgets/AiAssistChat/bloc/chatbox_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoicechatCubit extends Cubit<bool> {
  final _speechtotext = SpeechToText();
  String recoSpeech = '';
  String output = '';

  VoicechatCubit() : super(false);
  Future<void> pressedButton() async {
    emit(true);
    PermissionStatus perm = await Permission.microphone.request();
    if (perm.isGranted) {
      await _speechtotext.initialize();
      _speechtotext.listen(
        onResult: (result) {
          recoSpeech = result.recognizedWords;
        },
      );
    }
  }

  void releasedButton(BuildContext context) {
    emit(false);
    _speechtotext.stop();
    output = recoSpeech;
	context.read<AiCubit>().sendText(output);
  }
}
