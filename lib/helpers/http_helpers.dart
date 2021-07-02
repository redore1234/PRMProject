import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const DOMAIN = 'https://8a2a05c530a7.ngrok.io/api/v1';
// const DOMAIN = 'http://127.0.0.1/api/';
const LOGIN_ENDPOINT = DOMAIN + '/login';
const SUBJECT_ENDPOINT = DOMAIN + '/subjects';
const MAJOR_ENDPOINT = DOMAIN + '/majors';


class HttpHelper {
  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {String bearerToken}) async {
    return (await http
        .post(Uri.parse(url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
    }));
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body,
      {String bearerToken}) async {
    return (await http.put(Uri.parse(url),
      body: jsonEncode(body),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
      },
    ));
  }

  static Future<http.Response> get(String url, {String bearerToken}) async {
    return await http.get(Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $bearerToken'});
  }
}
