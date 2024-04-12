import 'package:green_score/models/bank.dart';
import 'package:green_score/models/merchant.dart';
import 'package:green_score/models/product.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/utils/http_request.dart';

class CustomerApi extends HttpRequest {
  bankGet(String id) async {
    var res = await get("/bank/$id", handler: true);
    return Bank.fromJson(res as Map<String, dynamic>);
  }

  bankList(ResultArguments resultArguments) async {
    var res = await get('/bank', data: resultArguments.toJson());
    return Result.fromJson(res, Bank.fromJson);
  }

  merchantList(ResultArguments resultArguments) async {
    var res = await get('/merchant', data: resultArguments.toJson());
    return Result.fromJson(res, Merchant.fromJson);
  }

  productList(ResultArguments resultArguments) async {
    var res = await get('/product/', data: resultArguments.toJson());
    return Result.fromJson(res, Product.fromJson);
  }
}
