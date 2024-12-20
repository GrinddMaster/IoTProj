import 'package:flutter/material.dart';
import 'package:advnet/Widgets/Voice_chat/bloc/voicechat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VoiceChatWidget extends StatelessWidget {
  const VoiceChatWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoicechatCubit, bool>(
      builder: (BuildContext context, bool isPressed) {
        return GestureDetector(
          onLongPressStart: (_) {
            context.read<VoicechatCubit>().pressedButton();
          },
          onLongPressEnd: (_) {
            context.read<VoicechatCubit>().releasedButton();
          },
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isPressed ? Colors.greenAccent : Colors.blueAccent,
            ),
            child: Icon(Icons.mic),
          ),
        );
      },
    );
  }
}
