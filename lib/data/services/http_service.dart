import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl = "https://example.com/api";

  // Example GET request
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/data'));

    if (response.statusCode == 200) {
      // Successful GET request
      final data = jsonDecode(response.body);
      debugPrint('GET request successful: $data');
    } else {
      // Handle errors
      debugPrint('GET request failed with status: ${response.statusCode}');
    }
  }

  // Example POST request
  Future<void> postData(Map<String, dynamic> postData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data'),
      body: jsonEncode(postData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Successful POST request
      final data = jsonDecode(response.body);
      debugPrint('POST request successful: $data');
    } else {
      // Handle errors
      debugPrint('POST request failed with status: ${response.statusCode}');
    }
  }

  // Example DELETE request
  Future<void> deleteData(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/data/$id'));

    if (response.statusCode == 200) {
      // Successful DELETE request
      debugPrint('DELETE request successful');
    } else {
      // Handle errors
      debugPrint('DELETE request failed with status: ${response.statusCode}');
    }
  }
}
