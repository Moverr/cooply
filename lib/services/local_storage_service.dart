import 'package:Cooply/models/dtos/requests/farm_request.dart';

import '../models/dtos/farm.dart';

class LocalStorageService {
  PaginatedFarmsResponse offlineQueue = new PaginatedFarmsResponse(content: [], totalElements: 0, pageNumber: 0, pageSize: 0);
  // new PaginatedFarmsResponse(content: content, totalElements: totalElements, pageNumber: pageNumber, pageSize: pageSize)

  Future<void> queueFarm(Farm farm) async {
    offlineQueue.content.add(farm);
  }

  List<Farm> getQueuedFarms() => offlineQueue.content;

  Future<void> clearQueue() async {
     offlineQueue = new PaginatedFarmsResponse(content: [], totalElements: 0, pageNumber: 0, pageSize: 0);
  }


}
