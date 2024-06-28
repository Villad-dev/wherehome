import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HttpController {
  final baseUrl = const String.fromEnvironment('BACKEND_URL');

  Future<void> sendGetRequest(
    String path,
    Map<String, String>? headers,
    void Function(http.Response) onSuccess,
    void Function(http.Response) onFail,
  ) async {
    final url = Uri.parse('$baseUrl/$path');
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        onFail(response);
      }
    } catch (e) {
      //  print('Error occurred: $e');
      onFail(http.Response('Something went wrong', 404));
      throw Exception('Failed to send GET request');
    }
  }

  Future<void> sendPostRequest(
    String path,
    Map<String, String>? headers,
    dynamic jsonBody,
    void Function(http.Response) onSuccess,
    void Function(http.Response) onFail,
  ) async {
    final url = Uri.parse('$baseUrl/$path');

    //print(url);
    //print(json.encode(jsonBody));

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(jsonBody),
      );

      //print(response.body);

      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        //print('Failed to send POST request: ${response.statusCode}');
        onFail(response);
      }
    } catch (e) {
      throw Exception('Failed to send POST request');
    }
  }

  Future<void> sendPutRequest(
    String path,
    Map<String, String>? headers,
    dynamic jsonBody,
    void Function(http.Response) onSuccess,
    void Function(http.Response) onFail,
  ) async {
    final url = Uri.parse('$baseUrl/$path');
    try {
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(jsonBody),
      );
      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        onFail(response);
      }
    } catch (e) {
      throw Exception('Failed to send PUT request');
    }
  }

  Future<void> sendDeleteRequest(
    String path,
    Map<String, String>? headers,
    dynamic jsonBody,
    void Function(http.Response) onSuccess,
    void Function(http.Response) onFail,
  ) async {
    final url = Uri.parse('$baseUrl/$path');
    try {
      final response = await http.delete(
        url,
        headers: headers,
        body: json.encode(jsonBody),
      );
      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        onFail(response);
      }
    } catch (e) {
      throw Exception('Failed to send DELETE request');
    }
  }

  Future<void> uploadImages(
    String path,
    List<File> images,
    Map<String, String>? headers,
    void Function(http.Response) onSuccess,
    void Function(http.Response) onFail,
  ) async {
    final url = Uri.parse('$baseUrl/$path');
    var request = http.MultipartRequest('POST', url);

    request.headers.addAll(headers!);

    for (int i = 0; i < images.length; i++) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'file$i',
          images.elementAt(i).path,
          filename: 'uploaded[$i]',
        ),
      );
    }

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        onSuccess(response);
      } else {
        onFail(response);
      }
    } catch (e) {
      throw ('Error uploading images: $e');
    }
  }

  Future<Image?> fetchImage(String imagePath) async {
    final url = Uri.parse('$baseUrl/$imagePath');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Uint8List bytes = response.bodyBytes;
        if (bytes.isNotEmpty) {
          return Image.memory(
            bytes,
            fit: BoxFit.fill,
          );
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
