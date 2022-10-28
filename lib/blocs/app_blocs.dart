import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/blocs/app_events.dart';
import 'package:flutter_bloc_example/blocs/app_state.dart';
import 'package:flutter_bloc_example/repositories/repository.dart';

class SpaceXBloc extends Bloc<SpaceXEvent, SpaceXState> {
  final SpaceXRepostitory _spaceXRepostitory;

  SpaceXBloc(this._spaceXRepostitory) : super(SpaceXLoadingState()) {
    on<LoadSpaceXEvent>((event, emit) async {
      emit(SpaceXLoadingState());
      try {
        final spaceXLaunches = await _spaceXRepostitory.getSpaceXLaunchesData();
        final randomNumber = await _spaceXRepostitory.getRandomNumber();//To demonstrate refresh
        emit(SpaceXLoadedState(spaceXLaunches, randomNumber));
      } catch (e) {
        emit(SpaceXErrorState(e.toString()));
      }
    });
  }
}
