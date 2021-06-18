import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const DOMAIN = 'https://testapi.net/api/';
// const DOMAIN = 'http://127.0.0.1/api/';
const LOGIN_ENDPOINT = DOMAIN + 'login';
const BOOKING_ENDPOINT = DOMAIN + 'booking';

class HttpHelper {
  static Future<http.Response> post(String url, Map<String, dynamic> body,
      {String bearerToken}) async {
    return (await http.post(Uri.https(DOMAIN, url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
    }));
  }

  static Future<http.Response> put(String url, Map<String, dynamic> body,
      {String bearerToken}) async {
    return (await http.put(Uri.https(DOMAIN, url), body: jsonEncode(body), headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
    }));
  }

  static Future<http.Response> get(String url, {String bearerToken}) async {
    return await http.get(Uri.https(DOMAIN, url),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $bearerToken'});
  }
}