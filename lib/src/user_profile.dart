import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> userData(accessToken) async {

  final response = await http.get(
    'https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }