import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

abstract class AiState {}

class AiResponse extends AiState {
  final String response;
  AiResponse(this.response);
}

class AiError extends AiState {
  final String error;
  AiError(this.error);
}

class AiInitState extends AiState {}

class AiCubit extends Cubit<AiState> {
  final String _apikey = '';
  final String _url = 'https://api.openai.com/v1/chat/completions';

  AiCubit() : super(AiInitState());

  void sendText(String message) async {
    final Map<String, Object> body;
    final header = {
      'Authorization': 'Bearer $_apikey',
      'Content-type': 'application/json',
    };
    if (message == null) {
      body = {};
      print("Empty body~");
    } else {
      body = {
        'model': 'gpt-4o-mini',
        'messages': [
          {"role": "user", "content": message},
        ],
        'max_tokens': 2048,
        'temperature': 0.7,
      };
    }

    final response = await http.post(
      Uri.parse(_url),
      headers: header,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      emit(AiResponse(jsonData['choices'][0]['message']['content']));
    } else {
      emit(AiError('Failed Response: ${response.statusCode}'));
    }
  }
}
