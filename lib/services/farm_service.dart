import 'package:Cooply/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/dtos/farm.dart';
import '../models/dtos/loginResponse.dart';
import '../models/dtos/requests/farm_request.dart';
import '../utils/AppConstants.dart';

class FarmService {
  final String baseUrl = "${AppConstants.BASE_URL}${AppConstants.FARMENDPOINT}";
  final String baseApi = "${AppConstants.BASE_URL}v1";

  get token => "Token and also"; //todo: get the token from other apps

  Dio initDio(String baseUrl, String? authToken) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Authorization': authToken != null ? 'Bearer $authToken' : '',
          'Accept': '*/*',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<PaginatedFarmsResponse?> getFarms(
      {
          int? accountId,
        int? offset,
        int? limit,
      required LoginResponse? loginResponse}) async
  {
    print('URL  : ${AppConstants.BASE_URL}v1/farm');

    // print('Inside  : ${authProvider.refreshToken}');

    print('Account ID  : $accountId');

    //todo: always do a service side health check. before pushing.
    //todo: get the signals
    debugPrint("logResponse ${loginResponse?.auth_token}");
    final dio = initDio(AppConstants.LOCAL_BASE_URL, loginResponse?.auth_token);

    try {
      debugPrint("-------- ");

      final response = await dio.get(
        'v1/farm',
        // 'actuator',
        queryParameters: {
          'account_id': accountId, // the calling agent, will determine the account to choose
          'offset': '${offset}',
          'limit': '${limit}',
          'sort_by': 'id',
          'sort_type': 'desc',
        },
      );

      // Optionally check or log response
      if (response.statusCode == 200) {
        final data = response.data;
        return PaginatedFarmsResponse.fromJson(data);

        // Handle data
      } else {
        // Handle error
        //  return PaginatedFarmsResponse.fromJson(a);
        debugPrint("There is a Null Response");
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with a status code (e.g., 400, 500)
        print('Status code: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
        print('Headers: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request (like network error)
        print('Error sending request: ${e.message}');
      }
    } catch (e, stackTrace) {
      // Log the error for debugging purposes
      debugPrint('Error fetching farms: $e');
      debugPrint('Stack trace: $stackTrace');

      // Optionally, rethrow or throw a custom exception
      throw Exception('Failed to fetch farms: $e');
    }
    return null;
  }

  Future<void> createFarm({
    required FarmRequest farm,
     LoginResponse? loginResponse,
    required int accountId,
  }) async {
    print('URL  : ${AppConstants.BASE_URL}v1/farm');

    // print('Inside  : ${authProvider.refreshToken}');

    print('Account ID  : $accountId');

    //todo: always do a service side health check. before pushing.
    //todo: get the signals
    debugPrint("logResponse ${loginResponse?.auth_token}");
    final dio = initDio(AppConstants.LOCAL_BASE_URL, loginResponse?.auth_token);

    await dio.post('/v1/farm', data: {
      "account_id": accountId, // Replace or pass dynamically
      "name": farm.name,
      "addresses": farm.addresses.map((a) => a.toJson()).toList()
    });
  }


  Future<void> updateFarm({
    required FarmRequest farm,
    required LoginResponse? loginResponse,
    required int accountId,
  }) async {
    print('URL  : ${AppConstants.BASE_URL}v1/farm');

    // print('Inside  : ${authProvider.refreshToken}');

    print('Account ID  : $accountId');

    //todo: always do a service side health check. before pushing.
    //todo: get the signals
    debugPrint("logResponse ${loginResponse?.auth_token}");
    final dio = initDio(AppConstants.LOCAL_BASE_URL, loginResponse?.auth_token);

    await dio.put('/v1/farm/${farm.id}', data: {
      "account_id": accountId, // Replace or pass dynamically
      "name": farm.name,
      "addresses": farm.addresses.map((a) => a.toJson()).toList()
    });
  }



  Future<void> deleteFarm({
  required int  accountId,required int id,
    required LoginResponse? loginResponse
}) async {

    try {
      final dio = initDio(AppConstants.LOCAL_BASE_URL, loginResponse?.auth_token);


      final response = await dio.delete(
        '/v1/farm/delete/$id',
        queryParameters: {
          "account_id": accountId, // passed in URL as ?account_id=...
        },
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );

      if (response.statusCode == 200) {
        print("Farm deleted successfully");
      } else {
        print("Failed to delete farm: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print("Dio error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("Unexpected error: $e");
    }


  }
}
