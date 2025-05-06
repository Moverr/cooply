import 'package:dio/dio.dart';

import '../models/dtos/Farm.dart';
import '../utils/AppConstants.dart';

class FarmService {


  final String baseUrl = "${AppConstants.BASE_URL}${AppConstants.FARMENDPOINT}";
  final String baseApi = "http://52.207.255.31:8082/v1";

  initDio(String baseUrl) => Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10), // Timeout for connection
      receiveTimeout:
      const Duration(seconds: 10), // Timeout for receiving data
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    ),
  );


  Future<PaginatedFarmsResponse> fetchFarms({
    required int accountId,
    required int offset,
    required int limit,
  }) async {
    final response =  await initDio(AppConstants.BASE_URL)
        .get('v1/farm', queryParameters: {
      'account_id': accountId,
      'offset': offset,
      'limit': limit,
      'sort_by': 'id',
      'sort_type': 'desc',
    });

    return PaginatedFarmsResponse.fromJson(response.data);
  }
}
