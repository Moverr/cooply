import 'package:Cooply/models/dtos/accountResponse.dart';
import 'package:Cooply/models/dtos/requests/farm_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/dtos/farm.dart';
import '../repositories/farm_repository.dart';
import 'farm_event.dart';
import 'farm_state.dart';

class FarmBloc extends Bloc<FarmEvent, FarmState> {
  final FarmRepository repository;


  FarmBloc(this.repository) : super(FarmInitial()) {
    on<LoadFarms>((event, emit) async {
      emit(FarmLoading());
      try {
        List<Farm>? farms = await repository.getFarms(isOnline: event.isOnline);
        emit(FarmLoaded(farms!));
      } catch (e) {
        emit(FarmError(e.toString()));
      }
    });


    /*
    required FarmRequest farmRequest ,

    LoginResponse? loginResponse,
    int? accountId
    , required bool isOnline
    */

    on<CreateFarm>((event, emit) async {
      if (state is FarmLoaded) {
        final current = (state as FarmLoaded).farms;
        emit(FarmLoading());
        await repository.createFarm(
          farmRequest:   event.farm, loginResponse: null,
            accountId: 0,
            isOnline: event.isOnline);

        FarmRequest fr = event.farm;
        Farm fm = getFarm(fr);

          emit(FarmLoaded(List.from(current)
          ..add(fm)));
      }
    });


    on<SyncOfflineFarms>((event, emit) async {
      if (state is FarmLoaded) {
        emit(FarmLoading());
        await repository.syncOffline();
        final farms = await repository.getFarms(isOnline: true);
        emit(FarmLoaded(farms!));
      }
    });

  }

  Farm getFarm(FarmRequest fr) =>    Farm(id: 0, name: fr.name, author: "Unknown", status: null, account:  AccountResponse(id: 1, name: "UNKNOWN", author: "UNKNOWN", referenceId: "UNKNOWN"), createdOn: null, modifiedOn: null, coops: null, flock: null);



  }