import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/location_info.dart';
import 'package:green_score/utils/http_request.dart';

class ScoreApi extends HttpRequest {
  sendStep(Accumlation data) async {
    var res = await post('/walk/add', "SCORE", data: data.toJson());
    return Accumlation.fromJson(res);
  }

  getStep(String type, String code) async {
    var res = await get('/accumlation/$type/$code', "SCORE");
    return res != null ? Accumlation.fromJson(res) : res;
  }
  // getStep(String type) async {
  //   var res = await get('/accumlation/$type', "SCORE");
  //   return res != null ? Accumlation.fromJson(res) : res;
  // }

  onRedeem(String id) async {
    var res = await post('/redeem/$id', "SCORE", handler: true);
    return res;
  }

  trackLocation(LocationInfo data) async {
    var res = await post('/track/add', "SCORE", data: data.toJson());
    return LocationInfo.fromJson(res);
  }
}
