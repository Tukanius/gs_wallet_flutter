import 'package:green_score/models/merchant.dart';
import 'package:green_score/models/product.dart';
import 'package:green_score/models/result.dart';
import 'package:green_score/utils/http_request.dart';

class ProductApi extends HttpRequest {
  getMerchant(ResultArguments resultArguments) async {
    var res =
        await get('/merchant', "MERCHANT", data: resultArguments.toJson());
    return Result.fromJson(res, Merchant.fromJson);
  }

  getProduct(ResultArguments resultArguments) async {
    var res = await get('/product', "MERCHANT", data: resultArguments.toJson());
    return Result.fromJson(res, Product.fromJson);
  }
}
