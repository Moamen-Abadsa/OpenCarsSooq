import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../functions/check_internet.dart';
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, Map>> postData(
      String linkUrl, Map? dataMap, List? dataList) async {
    try {
      if (await checkInternet()) {
        // print('linkUrl: $linkUrl');
        var result = await http.post(Uri.parse(linkUrl),
            headers: {"Content-Type": "application/json"},
            body: dataMap != null ? json.encode(dataMap) : json.encode(dataList));

        if (result.statusCode == 200 || result.statusCode == 201) {
          var responseBody = jsonDecode(result.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String linkUrl) async {
    try {
      if (await checkInternet()) {
        // print('linkUrl: $linkUrl');
        var result = await http.get(Uri.parse(linkUrl),
            headers: {"Content-Type": "application/json"});
        if (result.statusCode == 200 || result.statusCode == 201) {
          var responseBody = jsonDecode(result.body);
          if (responseBody['data'] != null) {
            return Right(responseBody);
          } else {
            return const Left(StatusRequest.noDataFailure);
          }
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}
