import 'package:green_score/utils/http_request.dart';
import 'package:green_score/models/general.dart';

class GeneralApi extends HttpRequest {
  init(bool hander) async {
    var res = await get('/general/init', handler: hander);
    return General.fromJson(res as Map<String, dynamic>);
  }
}
