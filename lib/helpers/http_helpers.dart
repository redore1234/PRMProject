import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const DOMAIN = 'http://193a97ddc607.ngrok.io/api/v1';
const DOMAIN_SEARCH_STUDENT = 'http://193a97ddc607.ngrok.io/v1.1';
const LOGIN_ENDPOINT = DOMAIN + '/auths/login-google';
const SUBJECT_ENDPOINT = DOMAIN + '/subjects';
const MAJOR_ENDPOINT = DOMAIN + '/majors';
const STUDENT_ENDPOINT = DOMAIN + '/students';
const PLANSEMESTER_ENPOINT = DOMAIN + '/plan-semester';
const SEMESTER_ENPOINT = DOMAIN + '/semesters';
const SEARCH_STUDENT_ENPOINT = DOMAIN_SEARCH_STUDENT + '/students';
const PLANSUBJECT_ENPOINT = DOMAIN + '/plan-subjects';
const TOPIC_ENPOINT = DOMAIN + '/topic';
const PLANTOPIC_ENPOINT = DOMAIN + '/plan-topics';
const TASK_ENPOINT = DOMAIN + '/tasks';



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
