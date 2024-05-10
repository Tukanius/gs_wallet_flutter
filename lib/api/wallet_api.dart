import 'package:green_score/models/account.dart';
import 'package:green_score/models/deposit.dart';
import 'package:green_score/models/history.dart';
import 'package:green_score/models/qr_read.dart';
import 'package:green_score/models/result.dart';

import 'package:green_score/utils/http_request.dart';

class WalletApi extends HttpRequest {
  getWalletList(ResultArguments resultArguments) async {
    var res = await get('/account', "WALLET", data: resultArguments.toJson());
    return Result.fromJson(res, Account.fromJson);
  }

  getAccount(String id) async {
    var res = await get('/account/$id', "WALLET");
    return Account.fromJson(res);
  }

  depositAccount(String id, Deposit data) async {
    var res = await post('/account/$id/deposit', "WALLET", data: data.toJson());
    return Deposit.fromJson(res);
  }

  depositConfirm(String id) async {
    var res = await post('/payment/$id/confirm', "INVOICE", handler: true);
    return Deposit.fromJson(res);
  }

  readQr(String id, QrRead iv) async {
    var res = await post('/qr/$id/scan', "MERCHANT",
        data: iv.toJson(), handler: true);
    return QrRead.fromJson(res);
  }

  confirmQr(String id) async {
    var res = await post('/order/$id/confirm', "MERCHANT", handler: true);
    return Deposit.fromJson(res);
  }

  walletHistory(ResultArguments resultArguments) async {
    var res = await get('/transaction', "TRANSACTION",
        data: resultArguments.toJson());
    return Result.fromJson(res, History.fromJson);
  }
}
