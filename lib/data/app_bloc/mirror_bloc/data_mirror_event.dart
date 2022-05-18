part of 'data_mirror_bloc.dart';

@immutable
abstract class DataMirrorEvent {
  const DataMirrorEvent();
}

class DataProviderChanged extends DataMirrorEvent{
  const DataProviderChanged();
}

class DataProviderLocal extends DataMirrorEvent{}

class DataProviderCloud extends DataMirrorEvent{}


