import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
@immutable
abstract class SpaceXEvent extends Equatable{
  const SpaceXEvent();
}

class LoadSpaceXEvent extends SpaceXEvent{
  @override
  List<Object?> get props => [];
}
