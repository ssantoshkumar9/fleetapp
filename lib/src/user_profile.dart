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
  
    'https://trackany-qa.azurewebsites.net/Account/AccountLogin?token=$accessToken',
   // headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
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

    // final http.Response response =
    // await http.post(Uri.encodeFull(url), body: activityData);
  final response = await http.get(Uri.encodeFull('https://trackanyqa-webapi.azurewebsites.net/api/GetVehicleEventsList/$deviceIdentifier/2019-08-12/$email/')
   
    ,
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }