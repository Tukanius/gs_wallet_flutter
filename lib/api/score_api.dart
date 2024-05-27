import 'package:green_score/models/accumlation.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/models/history.dart';
import 'package:green_score/models/location_info.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/utils/http_request.dart';

class ScoreApi extends HttpRequest {
  sendStep(Accumlation data) async {
    var res = await post('/walk/add', "SCORE", data: data.toJson());
    return Accumlation.fromJson(res);
  }

  getStep(Accumlation data) async {
    var res = await get('/accumlation', "SCORE", data: data.toJson());
    return Accumlation.fromJson(res);
  }

  getStepHistory(ResultArguments resultArguments) async {
    var res = await get('/accumlation/history', "SCORE",
        data: resultArguments.toJson());
    return Result.fromJson(res, History.fromJson);
  }

  redeemCalculate(String id) async {
    var res = await post('/redeem/calculate/$id', "SCORE");
    return Deposit.fromJson(res);
  }

  onRedeem(String id) async {
    var res = await post('/redeem/$id', "SCORE", handler: true);
    return res;
  }

  trackLocation(LocationInfo data) async {
    var res = await post('/track/add', "SCORE", data: data.toJson());
    return LocationInfo.fromJson(res);
  }
}
