import 'dart:async';
import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/repositories/app_config.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
class GetDriversApiClient{

 final http.Client httpClient;

  GetDriversApiClient({@required this.httpClient}) : assert(httpClient != null);
Future<GetDrivers> fetchDriversList() async {

   final response = await this.httpClient.get(ApiUrls.driversListUrl);
    //final response = await this.httpClient.get(ApiUrls.caseStudyListUrl+ id);
    if (response.statusCode == 200) {
    var driversList = getDriversFromJson(response.body);
    return driversList;
    }
    // else if (response.statusCode == 404) {
    //  throw new DataNotFoundException("No data found");
    // }
  }
}