import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_example/models/random_number.dart';
import 'package:flutter_bloc_example/models/spacex_model.dart';

@immutable
abstract class SpaceXState extends Equatable {}

//data loading state
class SpaceXLoadingState extends SpaceXState {
  @override
  List<Object?> get props => [];
}

//data loaded state
class SpaceXLoadedState extends SpaceXState {
  final List<SpaceX> spaceXLaunches;
  final List<RandomNumber> randomNumber;//To demonstrate refresh

  SpaceXLoadedState(this.spaceXLaunches, this.randomNumber);
  @override
  List<Object?> get props => [spaceXLaunches,randomNumber];
}

//data could not load state
class SpaceXErrorState extends SpaceXState {
  final String error;
  SpaceXErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
