import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_mirror_event.dart';
part 'data_mirror_state.dart';

class DataMirrorBloc extends Bloc<DataMirrorEvent, DataMirrorState> {
  DataMirrorBloc() : super(DataMirrorInitial());

  @override
  Stream<DataMirrorState> mapEventToState(
    DataMirrorEvent event,) async* {



  }
}
