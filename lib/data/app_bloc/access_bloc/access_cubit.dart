import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'access_state.dart';

class AccessCubit extends Cubit<AccessState> {
  AccessCubit(Future<bool> acc) : super(AccessState(acc));
}
