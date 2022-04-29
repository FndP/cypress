import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cypress/utils/constants.dart' as constants;
import 'custom_exception.dart';

class ApiProvider {

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      var response = await http.get(Uri.parse(constants.baseUrl + url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      constants.printLog(response.request);
      responseJson = _response(response);
    } on SocketException {
      throw NoInternetException("No Internet Connection!");
    }
    return responseJson;
  }


  dynamic _response(http.Response response) {
    constants.printLog(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        constants.printLog(responseJson);
        return responseJson;
      case 201:
      case 204:
        var responseJson = json.decode(response.body.toString());
        constants.printLog(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        return responseJson;
      case 302:
      case 401:

        throw UnauthorisedException("Something went wrong");
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 412:
        var responseJson = json.decode(response.body.toString());
        constants.printLog(responseJson);

        return UnauthorisedException(responseJson);

      case 500:
        var responseJson = json.decode(response.body.toString());
        var error = responseJson["errors"] ?? "";
        var msg = "";

        throw BadRequestException(msg);
      case 422:
        var responseJson = json.decode(response.body.toString());
        var msg = responseJson["message"];
        throw BadRequestException(msg);
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
