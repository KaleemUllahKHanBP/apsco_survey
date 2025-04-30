// import 'dart:developer';
//
// import 'package:fpdart/fpdart.dart';
// import 'package:survey/networks_api/response_handler.dart';
// import '../screen/store/model/add_store_model.dart';
// import 'app_url/application_url.dart';
// import 'error/failures.dart';
//
// class HTTPManager {
//   final ResponseHandler _handler = ResponseHandler();
//
//   Future<Either<Failure, AddStoreResponseModel>> saveStoreData(AddStoreDetailModel data) async {
//     var url = ApplicationURLs.baseUrl+ApplicationURLs.saveApscoStore;
//     log(url);
//     print(data.toJson());
//     final response = await _handler.postWithJsonRequestToken(Uri.parse(url),data);
//     return response.map(
//           (right) => AddStoreResponseModel.fromJson(right),
//     );
//   }
// }


import 'dart:convert';
import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:survey/networks_api/error/failures.dart';
import 'package:survey/networks_api/response_handler.dart';

import '../screen/store/model/add_store_model.dart';
import '../screen/store/model/city_list_model.dart';
import '../screen/survey/model/apsco_saving_model.dart';
import '../utils/dialog/logout_model.dart';
import 'app_exceptions.dart';
import 'app_url/application_url.dart';

class HTTPManager {
  final ResponseHandler _handler = ResponseHandler();
  Future<AddStoreResponseModel> saveStoreData(
      AddStoreDetailModel addStoreDetailModel) async {
    const url =ApplicationURLs.baseUrl+ApplicationURLs.saveApscoStore;
    print(url);
    print(jsonEncode(addStoreDetailModel));
    final response =
    await _handler.postWithToken(Uri.parse(url), addStoreDetailModel.toJson());
    AddStoreResponseModel addStoreResponseModel = AddStoreResponseModel.fromJson(response);
    return addStoreResponseModel;
  }


  Future<dynamic> saveSurveyData(
      ApscoSurveyRequest apscoSurveyRequest) async {
    const url =ApplicationURLs.baseUrl+ApplicationURLs.saveApscoSurvey;
    print(url);
    print(jsonEncode(apscoSurveyRequest));
    final response =
    await _handler.postWithToken(Uri.parse(url), apscoSurveyRequest.toJson());

    return response;
  }


  Future<CityResponseModel> fetchRegionList() async {
    var url =ApplicationURLs.baseUrl+ApplicationURLs.getRegions;
    log(url);
    final response = await _handler.get(Uri.parse(url));
    CityResponseModel cityResponseModel = CityResponseModel.fromJson(response);
    return cityResponseModel;
  }

  Future<CityResponseModel> getCityListData(int id) async {
    var url =ApplicationURLs.baseUrl+ApplicationURLs.getCities;
    final Map<String, dynamic> loadData = {
      "region_id": id.toString(),
    };
    log(url);
    final response = await _handler.postCity(Uri.parse(url),loadData);
    CityResponseModel cityResponseModel = CityResponseModel.fromJson(response);
    return cityResponseModel;
  }

}


