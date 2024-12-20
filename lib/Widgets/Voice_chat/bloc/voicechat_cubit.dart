import 'package:bloc/bloc.dart';

class VoicechatCubit extends Cubit<bool> {
  VoicechatCubit() : super(false);
  void pressedButton() => emit(true);
  void releasedButton() => emit(false);
}
