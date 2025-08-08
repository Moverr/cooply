import 'package:Cooply/models/dtos/requests/farm_request.dart';

import '../models/dtos/farm.dart';
import '../models/dtos/loginResponse.dart';
import '../services/farm_service.dart';
import '../services/local_storage_service.dart';

class FarmRepository {
  final FarmService remote;
  final LocalStorageService local;

  FarmRepository({required this.remote, required this.local});

  Future<List<Farm>?> getFarms({
    required bool isOnline,
      int? accountId,
      int? offset,
      int? limit,
      LoginResponse? loginResponse


  }) async {
    if (isOnline) {
      PaginatedFarmsResponse? response =   await remote.getFarms(accountId: accountId, offset: offset, limit: limit, loginResponse: loginResponse);


      return response?.content;
    } else {
      return local.getQueuedFarms();
    }
  }

  Future<void> createFarm( {required FarmRequest farmRequest ,

      LoginResponse? loginResponse,
   required int accountId
  , required bool isOnline

  }) async {
    if (isOnline) {
      await remote.createFarm(
        farm: farmRequest,loginResponse: loginResponse,accountId: accountId);
    } else {
      //todo: generate farmResponse

      Farm farm = new Farm(id: 0, name: farmRequest.name, author: "", status: null, createdOn: null, modifiedOn: null, coops: null, flock: null);

      await local.queueFarm(farm);
    }
  }

  Future<void> syncOffline() async {
    final queued = local.getQueuedFarms();
    for (var farm in queued) {

      FarmRequest fr = new FarmRequest(accountId: 0, name: farm.name, addresses: []);
      await remote.createFarm(farm: fr,accountId: 0);
    }
    await local.clearQueue();
  }
}
