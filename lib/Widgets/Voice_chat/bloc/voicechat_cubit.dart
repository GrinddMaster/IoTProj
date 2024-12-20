import 'package:bloc/bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoicechatCubit extends Cubit<bool> {
  final _speechtotext = SpeechToText();
  String recoSpeech = '';

  VoicechatCubit() : super(false);
  void pressedButton() async {
    emit(true);
    bool available = await _speechtotext.initialize();
    if (available) {
      _speechtotext.listen(
        onResult: (result) {
          recoSpeech = result.recognizedWords;//TODO: Now I need to send this to the server.
        },
      );
    }
  }

  void releasedButton() {
    emit(false);
    _speechtotext.stop();
  }
}
