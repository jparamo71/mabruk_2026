import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Communication client-server using http(s) protocol
/// This custom class extension implement GET, POST and PUT methods
class HttpCustom extends http.BaseClient {
  final Map<String, String> _defaultHeaders = {'Accept': 'application/json'};

  Map<String, String> _mergedHeaders(Map<String, String> headers) => {
    ..._defaultHeaders,
    ...headers,
  };

  final http.Client _httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _httpClient.send(request).then((response) async {
      _checkError(await http.Response.fromStream(response));

      return response;
    });
  }

  @override
  Future<Response> get(url, {Map<String, String>? headers}) {
    return _httpClient
        .get(
          url,
          headers: headers != null ? _mergedHeaders(headers) : _defaultHeaders,
        )
        .then(_checkError);
  }

  @override
  Future<Response> post(
    url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
  }) {
    return _httpClient
        .post(
          url,
          headers: headers != null ? _mergedHeaders(headers) : _defaultHeaders,
          body: body,
          encoding: encoding,
        )
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            // Optional: Code to execute when a timeout occurs,
            // e.g., show a dialog, log the event, or return a default response.
            return http.Response(
              'Error: Request Timeout',
              408,
            ); // Return a custom response object
          },
        )
        .then(_checkError);
  }

  Future<bool> postFile(Uri url, String fileKey, String fileName, Uint8List fileData) async {
    var request = http.MultipartRequest("POST", url);
    request.files.add(
      http.MultipartFile.fromBytes(fileKey, fileData, filename: fileName),
    );
    var r = await request.send();
    return (r.statusCode == 200);
  }

  @override
  Future<Response> put(
    url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding,
  }) {
    return _httpClient
        .put(
          url,
          body: body,
          encoding: encoding,
          headers: headers != null ? _mergedHeaders(headers) : _defaultHeaders,
        )
        .then(_checkError);
  }


  @override
  Future<http.Response> delete(url, {
    Map<String, String>? headers,
    dynamic body,
    Encoding? encoding
  })
  {
    return _httpClient
        .delete(url, body: body, encoding: encoding, headers: headers)
    .then(_checkError);
  }

  Response _checkError(Response response) {
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      String url = response.request!.url.toString();
      log(
        'Unexpected error $statusCode${response.body}',
        name: 'Http client request $url',
        level: 4000,
      );
    }
    return response;
  }
}
