
import 'package:Cooply/models/dtos/requests/farm_request.dart';

abstract class FarmEvent{}

class LoadFarms extends FarmEvent{
  final bool isOnline;
  LoadFarms({required this.isOnline});
}


class CreateFarm extends FarmEvent {
  final FarmRequest farm;
  final bool isOnline;
  CreateFarm({required this.farm, required this.isOnline});
}

class SyncOfflineFarms extends FarmEvent {}


