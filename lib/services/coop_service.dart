import 'package:Cooply/models/dtos/requests/coop_request.dart';
import 'package:Cooply/services/service_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/dtos/Farm.dart';
import '../models/dtos/coop_response.dart';
import '../models/dtos/loginResponse.dart';
import '../utils/AppConstants.dart';

class CoopService {
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

  /**
    Create Coop
   */



  Future<ServiceResult> create({
    required CoopRequest coopRequest,
    LoginResponse? loginResponse,
    required int farmId,
  }) async {
    print('URL  : ${AppConstants.BASE_URL}v1/coop');
    print('Farm ID  : $farmId');
    debugPrint("logResponse ${loginResponse?.auth_token}");

    final dio = initDio(AppConstants.LOCAL_BASE_URL, loginResponse?.auth_token);

    try {

      final response = await dio.post(
        '/v1/coop',
        data: {
         "farm_id":farmId,
          "name": coopRequest.name,
          // "reference_id": coopRequest.referenceId, // UUID
          // "status": coopRequest.status, // e.g. "PENDING"
          "area": coopRequest.area,
          "capacity": coopRequest.capacity, // fixed typo from "cpaacity"
          "type": coopRequest.type, // e.g. "DEEP_LITTER"
          "power": coopRequest.power.map((p) => {
            "power_type": p.name,
            "status": p.status,
            // "details": p.details,
          }).toList(),
          "water": coopRequest.water.map((w) => {
            "water_type": w.source,
            "status": w.status,
            // "details": w.details,
          }).toList(),

        },
      );

      // Optionally check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ServiceResult(success: true);
      } else {
        return ServiceResult(
          success: false,
          errorMessage: 'Unexpected status code: ${response.statusCode}',
        );
      }
    } on DioError catch (e) {
      // Handle API errors
      String message = 'Failed to save coop';
      if (e.response != null && e.response?.data != null) {
        // Try to extract server error message
        final data = e.response?.data;
        if (data is Map && data['message'] != null) {
          message = data['message'];
        } else if (data is String) {
          message = data;
        }
      }
      return ServiceResult(success: false, errorMessage: message);
    } catch (e) {
      // Any other error
      return ServiceResult(success: false, errorMessage: e.toString());
    }
  }

  /**
   *  Get Coops
   */
  Future<List<CoopResponse>> getList(
      {
       required int farmId,
     required int offset,
      required int limit,
      required LoginResponse? loginResponse}) async {
    print('URL  : ${AppConstants.BASE_URL}v1/coop');

    print('Farm ID  : $farmId');

    debugPrint("logResponse ${loginResponse?.auth_token}");
    final dio = initDio(AppConstants.LOCAL_BASE_URL, loginResponse?.auth_token);

    try {
      debugPrint("-------- ");

      final response = await dio.get(
        'v1/coop',
        queryParameters: {
          'account_id':loginResponse!.defaultAccount.id,
          'farm_id':
              farmId, // the calling agent, will determine the account to choose
          'offset': '${offset}',
          'limit': '${limit}',
          'sort_by': 'id',
          'sort_type': 'desc',
        },
      );

      // Optionally check or log response
      if (response.statusCode == 200) {
        final data = response.data;

        print("Data ${data}");
        final List<CoopResponse> coops =
            (data as List).map((item) => CoopResponse.fromJson(item)).toList();

        return coops;

        // Handle data
      } else {
        // Handle error
        //  return PaginatedFarmsResponse.fromJson(a);
        debugPrint("There is a Null Response");
        return [];
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
      debugPrint('Error fetching coops: $e');
      debugPrint('Stack trace: $stackTrace');

      // Optionally, rethrow or throw a custom exception
      throw Exception('Failed to fetch farms: $e');
    }
    return [];
  }
}
