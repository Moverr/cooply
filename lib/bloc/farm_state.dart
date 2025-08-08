import '../models/dtos/farm.dart';

abstract class FarmState {}

class FarmInitial extends FarmState {}

class FarmLoading extends FarmState {}

class FarmLoaded extends FarmState {
  final List<Farm> farms;
  FarmLoaded(this.farms);
}

class FarmError extends FarmState {
  final String message;
  FarmError(this.message);
}
