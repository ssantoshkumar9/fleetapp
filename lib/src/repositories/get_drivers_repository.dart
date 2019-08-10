import 'package:fleetly/src/models/getdriver_model.dart';
import 'package:fleetly/src/repositories/get_drivers_api_client.dart';


import 'package:meta/meta.dart';
class GetDriversListRepository {
  final GetDriversApiClient getDriversApiClient;
  
  GetDriversListRepository({@required this.getDriversApiClient})
   :assert(getDriversApiClient != null);

Future <GetDrivers> getDriversList() async{
    return await getDriversApiClient.fetchDriversList();

  } 
}