import 'package:techsaga/Repository/api.dart';
import 'package:techsaga/Repository/api_urls.dart';
// import 'package:techsaga/Repository/Provider/location_provider.dart';

class GymApi {
  static Future<dynamic> getGymList() async {
    return Api().request(
      url: gymList,
      method: RequestMethod.post,
      header: Api.authHeader,
      queryParameters: {
        "latitude": 28.704060,
        // locationProvider.latlong?.split(",").first,
        //   current latitude no data then i am using static latitude
        "longitude": 77.102493,
        // locationProvider.latlong?.split(",").last,
        //   current longitude no data then i am using static longitude
      },
    );
  }
}
