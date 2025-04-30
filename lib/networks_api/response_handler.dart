
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/utils/app_constants.dart';
import 'package:survey/utils/sharedprefrences/shared_prefrences.dart';
import 'app_exceptions.dart';
import 'error/failures.dart';

late SharedPreferences _sharedPreferences;

class ResponseHandler {
  Map<String, String> setTokenHeader() {
    return {'': ''}; //{'Authorization': 'Bearer ${Constants.authenticatedToken}'};
  }

  Future postWithAgent(Uri url, Map<String, dynamic> params, String userAgent) async {
    var head = <String, String>{};
    head['Content-Type'] = 'application/json'; // Use JSON content type for sending JSON data
    head['User-Agent'] = userAgent;
    var responseJson;

    try {
      final response =
          await http.post(url, body: jsonEncode(params), headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
  }
  Future<dynamic> post(
      Uri url,
      Map<String, dynamic> params,
      ) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };

    try {
      final response = await http
          .post(url, body: jsonEncode(params), headers: headers)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        if (responseJson['status'] != true) {
          throw FetchDataException(responseJson['msg'].toString());
        }
        return responseJson;
      } else {
        throw FetchDataException("Server Error: ${response.statusCode}");
      }
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on FormatException {
      throw FetchDataException('Invalid response format');
    }
  }




  Future<dynamic> postCity(Uri url, Map<String, dynamic> params) async {
    var headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    print("Check city params: $params");

    try {
      final response = await http
          .post(url, body: params, headers: headers)
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        if (responseJson['status'] != true) {
          throw FetchDataException(responseJson['msg'].toString());
        }

        return responseJson;
      } else {
        throw FetchDataException("Server Error: ${response.statusCode}");
      }
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on FormatException {
      throw FetchDataException('Invalid response format');
    }
  }







  Future postWithToken(
    Uri url,
    Map<String, dynamic> params,
  ) async {
    String? token = await PrefUtils.instance.getString(AppConstants.token);
    print("Check token");
    print(token);

    var head = <String, String>{};
    head['Content-Type'] = 'application/json';
    head['Authorization'] = 'Bearer $token';
    // Use JSON content type for sending JSON data
    var responseJson;

    try {
      final response =
          await http.post(url, body: jsonEncode(params), headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) {
        throw FetchDataException(responseJson['msg'].toString());
      }
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future putWithToken(
    Uri url,
    Map<String, dynamic> params,
  ) async
  {/*
    _sharedPreferences = await SharedPreferences.getInstance();

    String token = _sharedPreferences.getString(UserConstants().userToken)!;*/
     String token = _sharedPreferences.getString("token")!;
    var head = <String, String>{};
    head['Content-Type'] = 'application/json';
    head['Authorization'] = 'Bearer $token';
    // Use JSON content type for sending JSON data
    var responseJson;

    try {
      final response =
          await http.put(url, body: jsonEncode(params), headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future putWithJsonRequestToken(
    Uri url,
    dynamic params,
  ) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    String token = _sharedPreferences.getString("token")!;

    var head = <String, String>{};
    head['Authorization'] = 'Bearer $token';
    head['content-type'] = 'application/json';
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    var params1 = utf8.encode(json.encode(params));
    try {
      final response = await http.put(url, body: params1, headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postWithBothString(
    Uri url,
    Map<String, String> params,
  ) async {
    var head = <String, String>{};
    head['content-type'] = 'application/json';
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      final response = await http.post(url, body: params, headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postWithBothStringWithToken(
    Uri url,
    Map<String, String> params,
  ) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String token = _sharedPreferences.getString("token")!;

    var head = <String, String>{};
    head['Authorization'] = 'Bearer $token';
    head['content-type'] = 'application/json';
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      final response = await http.post(url, body: params, headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postWithJsonRequest(
    Uri url,
    dynamic params,
  ) async {
    var head = <String, String>{};
    head['content-type'] = 'application/json';
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    var params1 = utf8.encode(json.encode(params));
    try {
      final response = await http.post(url, body: params1, headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }


  Future deleteWithJsonRequestTokenOld(
      Uri url,
      dynamic params,
      ) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String token = _sharedPreferences.getString("token")!;

    var head = <String, String>{};
    head['Authorization'] = 'Bearer $token';
    head['content-type'] = 'application/json';
    var responseJson;
    var params1 = utf8.encode(json.encode(params));
    try {
      final response = await http.delete(url, body: params1, headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['msg'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postFile(String url, File files) async {
    var head = <String, String>{};
    head['content-type'] = 'application/x-www-form-urlencoded';
    var res;
    var jsonData;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      if (files != null) {
        final file = await http.MultipartFile.fromPath(
            'file', files.path); //,contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
        request.files.add(file);
      }
      await request.send().then((response) {
        if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) print("Uploaded!");
        res = response.stream;
      });
      await for (List<int> chunk in res) {
        final chunkString = utf8.decode(chunk);
        jsonData = json.decode(chunkString);
        print('Received JSON data: $jsonData');
      }
      // if(res['status']!= true) throw FetchDataException(res['msg'].toString());
      return jsonData;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postFileWithToken(String url, File files) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String token = _sharedPreferences.getString("token")!;

    var head = <String, String>{};
    head['Authorization'] = 'Bearer $token';
    head['content-type'] = 'application/x-www-form-urlencoded';
    var res;
    var jsonData;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      if (files != null) {
        final file = await http.MultipartFile.fromPath(
            'file', files.path); //,contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
        request.files.add(file);
      }
      await request.send().then((response) {
        if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) print("Uploaded!");
        res = response.stream;
      });
      await for (List<int> chunk in res) {
        final chunkString = utf8.decode(chunk);
        jsonData = json.decode(chunkString);
        print('Received JSON data: $jsonData');
      }
      // if(res['status']!= true) throw FetchDataException(res['msg'].toString());
      return jsonData;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postImage(String url, File image) async {
    var head = <String, String>{};
    head['content-type'] = 'application/x-www-form-urlencoded';
    var res;
    var jsonData;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      if (image != null) {
        final file = await http.MultipartFile.fromPath(
            'image', image.path); //,contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
        request.files.add(file);
      }
      await request.send().then((response) {
        if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) print("Uploaded!");
        res = response.stream;
      });
      await for (List<int> chunk in res) {
        final chunkString = utf8.decode(chunk);
        jsonData = json.decode(chunkString);
        print('Received JSON data: $jsonData');
      }
      // if(res['status']!= true) throw FetchDataException(res['msg'].toString());
      return jsonData;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future postImageWithToken(String url, File image) async {
    _sharedPreferences = await SharedPreferences.getInstance();

    String token = _sharedPreferences.getString("token")!;

    var head = <String, String>{};
    head['Authorization'] = 'Bearer $token';
    head['content-type'] = 'application/x-www-form-urlencoded';
    var res;
    var jsonData;
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      if (image != null) {
        final file = await http.MultipartFile.fromPath(
            'image', image.path); //,contentType: MediaType(mimeTypeData[0], mimeTypeData[1])
        request.files.add(file);
      }
      await request.send().then((response) {
        if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) print("Uploaded!");
        res = response.stream;
      });
      await for (List<int> chunk in res) {
        final chunkString = utf8.decode(chunk);
        jsonData = json.decode(chunkString);
        print('Received JSON data: $jsonData');
      }
      // if(res['status']!= true) throw FetchDataException(res['msg'].toString());
      return jsonData;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future get(Uri url) async {
    var head = <String, String>{};
    head['content-type'] = 'application/json; charset=utf-8';
    head['Accept'] = "application/json";
    // ignore: prefer_typing_uninitialized_variables
    var responseJson;
    try {
      final response = await http.get(url, headers: head).timeout(const Duration(seconds: 30));
      responseJson = json.decode(response.body.toString());
      // ignore: avoid_print
      print(responseJson);
      if (responseJson['status'] != true) throw FetchDataException(responseJson['message'].toString());
      return responseJson;
    } on TimeoutException {
      throw FetchDataException("Slow internet connection");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }











  Future<Either<Failure, Map<String, dynamic>>> getWithToken(Uri url) async {
    try {
      // Retrieve the token from SharedPreferences
      _sharedPreferences = await SharedPreferences.getInstance();
      String? token = _sharedPreferences.getString("token");

      print(token);

      if (token == null) {
        return Left(Failure('Token not found'));
      }

      // Set up headers
      var head = <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      // Perform the GET request
      final response = await http
          .get(
        url,
        headers: head,
      )
          .timeout(const Duration(seconds: 30));

      // Decode the response
      final responseJson = json.decode(response.body.toString());

      print(responseJson);

      // Check response status
      if (responseJson['status'] != true) {
        return Left(Failure(responseJson['msg'].toString()));
      }

      return Right(responseJson);
    } on TimeoutException {
      return Left(Failure('Slow internet connection'));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }


  Future<Either<Failure, dynamic>> postWithJsonRequestToken(
      Uri url, dynamic params) async {
    String? token = PrefUtils.instance.getString(AppConstants.token).toString();
    if (token == null) {
      return Left(Failure('Token not found'));
    }
    var headers = {
      'Authorization': 'Bearer $token',
      'content-type': 'application/json',
    };
    var paramsEncoded = utf8.encode(json.encode(params));
    try {
      final response = await http
          .post(url, body: paramsEncoded, headers: headers)
          .timeout(const Duration(seconds: 30));

      final responseJson = json.decode(response.body);

      print("THIS IS THE REPONSE");
      print(responseJson);

      // Handle the response status
      if (responseJson['status'] != true) {
        return Left(Failure(responseJson['msg'].toString()));
      }
      return Right(responseJson);
    } on TimeoutException {
      return Left(Failure('Slow internet connection'));
    } on SocketException {
      return Left(Failure('No internet connection'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
