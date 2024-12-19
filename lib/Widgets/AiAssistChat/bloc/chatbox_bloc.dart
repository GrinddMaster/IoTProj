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
  final String _url = 'https://api.openai.com/v1/completions';

  AiCubit() : super(AiInitState());

  void sendText(String message) async {
    try {
      final header = {
        'Authorization': 'Bearer $_apikey',
        'Content-type': 'application/json',
      };
      final body = {
        'model': 'gpt-4o-mini',
        'prompt': message,
        'max-tokens': '2048',
        'tempreature': '0.7',
      };

      final response = await http.post(
        Uri.parse(_url),
        headers: header,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        emit(AiResponse(jsonData['choices'][0]['text']));
      } else {
        emit(AiError('Failed Response: ${response.statusCode}'));
      }
    } catch (message) {
      emit(AiError('Exception when sending: $message'));
    }
  }
}
