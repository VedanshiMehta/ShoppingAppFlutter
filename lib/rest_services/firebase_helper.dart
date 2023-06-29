import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoppingapp/constants/url/url_constants.dart';
import 'package:shoppingapp/result/result.dart';

class FireBaseHelper {
  static Future<Result> postAsync<T>(
      Map<String, Object> t, String endpoint) async {
    try {
      final url = Uri.https(UrlConstants.baseUrl, endpoint);

      var response = await http.post(
        url,
        headers: {UrlConstants.contentType: UrlConstants.applicatioJson},
        body: jsonEncode(t),
      );
      Map<String, dynamic> list = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Result(list, message: 'Data added successfully', isValid: true);
      } else {
        return const Result({},
            message: 'Something went wrong.', isValid: false);
      }
    } catch (error) {
      return Result({}, message: error.toString(), isValid: false);
    }
  }

  static Future<Result> getAsync(String endpoint) async {
    try {
      final url = Uri.https(UrlConstants.baseUrl, endpoint);
      var response = await http.get(url);
      if (response.body == 'null') {
        return const Result({}, message: 'No data found', isValid: false);
      }
      Map<String, dynamic> listData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Result(listData,
            message: 'Data added successfully', isValid: true);
      } else {
        return const Result({},
            message: 'Falied to fetch data,something went wrong.',
            isValid: false);
      }
    } catch (error) {
      return Result({}, message: error.toString(), isValid: false);
    }
  }

  static Future<Result> deleteAsync(String endpoint) async {
    try {
      final url = Uri.https(UrlConstants.baseUrl, endpoint);
      var response = await http.delete(url);
      if (response.statusCode == 200) {
        return const Result({}, message: 'Deleted Sucessfull', isValid: true);
      } else {
        return const Result({},
            message: 'Something went wrong.', isValid: false);
      }
    } catch (error) {
      return Result({}, message: error.toString(), isValid: false);
    }
  }
}
