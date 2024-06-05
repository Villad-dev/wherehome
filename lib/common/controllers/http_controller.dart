import 'package:http/http.dart' as http;

class HttpController {
  final baseUrl = 'http://172.29.16.1:8080';

  Future<http.Response> sendGetRequest() async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(url);
      print(response.body);
      return response;
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to send GET request');
    }
  }

  Future<void> sendPostRequest(
    String path,
    dynamic jsonBody,
    void Function(http.Response) onSuccess,
    void Function(http.Response) onFail,
  ) async {
    final url = Uri.parse('$baseUrl/$path');

    print(url);
    try {
      final response = await http.post(url, body: jsonBody);
      print(response.body);
      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        print('Failed to send POST request: ${response.statusCode}');
        onFail(response);
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to send POST request');
    }
  }
}
