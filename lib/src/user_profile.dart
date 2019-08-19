import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<http.Response> userData(accessToken) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/

  final response = await http.get(
    'https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }
  Future<http.Response> webViewData(accessToken) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/

  final response = await http.get(
    'https://trackany-qa.azurewebsites.net/',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }
  Future<http.Response> getDriversData(accessToken) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/

  final response = await http.get(
    'https://trackanyqa-webapi.azurewebsites.net/api/Devices/GetDriverForDriverDadhboard/',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }
  Future<http.Response> getEventsData(accessToken,deviceIdentifier,lastReportedTime,email) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/


  final response = await http.get(
   
    'https://trackanyqa-webapi.azurewebsites.net/api/GetVehicleEventsList/$deviceIdentifier/2019-08-19/$email',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }