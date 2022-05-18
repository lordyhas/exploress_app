import 'package:bloc/bloc.dart';
import 'package:exploress/data/app_database.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState.initial());
  
  void addSearchResult({
    List<ProductData>? result ,
    List<ProductData>?  history
  }){
    if(result == null)
      emit(state.withHistoryOnly(history: history!));
    else if(history == null)
      emit(state.withResultOnly(result: result));
    else emit(SearchState._(result: result, history: history));
  }
}
