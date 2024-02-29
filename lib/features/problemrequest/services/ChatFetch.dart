import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String > startInteract(String apiKey, String ?userID, Map<String, dynamic> body) async {
  try {
    // Start a conversation
    final response = await http.post(
      Uri.parse('https://general-runtime.voiceflow.com/state/user/$userID/interact'),
      headers: {
        'Authorization': apiKey,
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    // Return the response body
    return response.body;
  } catch (error) {
    return ""; // Return null in case of error
  }
}
