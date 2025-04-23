import 'package:dio/dio.dart';

class InitDio{
   static Dio init(String baseUrl)=>Dio(
     BaseOptions(
       baseUrl: baseUrl,
       connectTimeout: const Duration(seconds: 10), // Timeout for connection
       receiveTimeout: const Duration(seconds: 10), // Timeout for receiving data
       headers: {
         'accept': '*/*',
         'Content-Type': 'application/json',
       },
     ),
   );


}