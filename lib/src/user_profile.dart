import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fleetly/src/exceptions/data_not_found_exception.dart';
import 'package:http/http.dart' as http;

Future<http.Response> userData(accessToken) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/
  //'https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/',

  final response = await http.get(
    'https://api-qa.fleetly.tech/api/users/byUserName/',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");
  return  response;
    
  }
  Future<http.Response> webViewData(accessToken) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/
   //'https://trackany-qa.azurewebsites.net/Account/AccountLogin?token=$accessToken',

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
    'https://api.fleetly.tech/api/Devices/GetDriverForDriverDadhboard/',
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");
  return  response;
    
  }

 Future<http.Response> getEventsData(accessToken,lastReportedTime) async {
  //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/

    // final http.Response response =
    // await http.post(Uri.encodeFull(url), body: activityData);
  final response = await http.get(Uri.encodeFull('https://api.fleetly.tech/api/GetEvents/$lastReportedTime')
   
    ,
    headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  );
  print("Bearer $accessToken");

    
  return  response;
    
  }

  // Future<http.Response> getEventsData(accessToken,deviceIdentifier,lastReportedTime,userName) async {
  // //https://trackanyqa-webapi.azurewebsites.net/api/users/byUserName/

  //   // final http.Response response =
  //   // await http.post(Uri.encodeFull(url), body: activityData);
  // final response = await http.get(Uri.encodeFull('https://trackanyqa-webapi.azurewebsites.net/api/GetVehicleEventsList/$deviceIdentifier/2019-08-19/$userName/')
   
  //   ,
  //   headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
  // );
  // print("Bearer $accessToken");

    
  // return  response;
    
  // }

  Future<http.Response> fetchOTP(otpType,otpTypeValue,userName) async {
//https://trackanyqa-webapi.azurewebsites.net/api/users/VerifyUser/$otpType/$otpTypeValue/$userName/'
   final response = await http.get('https://api-qa.fleetly.tech/api/users/VerifyUser/$otpType/$otpTypeValue/$userName/');
    //final response = await this.httpClient.get(ApiUrls.caseStudyListUrl+ id);
    if (response.statusCode == 200) {
    //var str = response.body;
    return response;
    }
    else if (response.statusCode == 404) {
     throw new DataNotFoundException("No data found");
    }
  }
   Future<http.Response> confirmPassord(userName,newPassword) async {
//https://trackanyqa-webapi.azurewebsites.net/api/users/ResetPassword/$userName/$newPassword/
   final response = await http.get('https://api-qa.fleetly.tech/api/users/ResetPassword/$userName/$newPassword/');
    //final response = await this.httpClient.get(ApiUrls.caseStudyListUrl+ id);
    if (response.statusCode == 200) {
    //var str = response.body;
    return response;
    }
    else if (response.statusCode == 404) {
     throw new DataNotFoundException("No data found");
    }
  }