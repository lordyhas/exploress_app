part of 'data_mirror_bloc.dart';

@immutable
abstract class DataMirrorState {}

class DataMirrorInitial extends DataMirrorState {}
class DataMirrorFromLocal extends DataMirrorState {}
class DataMirrorFromCloud extends DataMirrorState {}
