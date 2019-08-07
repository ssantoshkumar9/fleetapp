import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;


// class LoginApiClient {
//    Future<dynamic> post(String url,var body)async{
//         return await http
//             .post(Uri.encodeFull(url), body: body, headers: {"Accept":"application/json"})
//             .then((http.Response response) {
//     //      print(response.body);
//           final int statusCode = response.statusCode;
//           if (statusCode < 200 || statusCode > 400 || json == null) {
//             throw new Exception("Error while fetching data");
//           }else{
//             print(response.body);
//          return  response;
//           }
//           // _decoder.convert(response.body);
//         });
//       }


// var httpClient = new HttpClient();

//   // LoginApiClient({@required this.httpClient}) : assert(httpClient != null);
//   Future<List> loginApi() async {
//     final response = await this.httpClient.post(url,body});
//     if (response. == 200) {
//             print(response);

//       // throw Exception('error getting locationId for city');
//     }
//     else{
//     }

//     // final locationJson = jsonDecode(response.body) as List;
//     // return (locationJson.first)['woeid'];
//   }
// }