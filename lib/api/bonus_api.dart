import 'package:green_score/utils/http_request.dart';

import '../models/user.dart';

class BonusApi extends HttpRequest {
  sendBonus(int id, int bonus) async {
    var res = await put('/bonus:$id', data: bonus, handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  putBonus(User user) async {
    var res =
        await put("/bonus/", data: (id: user.id, bonus: 100), handler: true);
    return User.fromJson(res as Map<String, dynamic>);
  }

  gerQr() async {
    var res = await post("/qr", handler: true);
    return res;
  }
}
