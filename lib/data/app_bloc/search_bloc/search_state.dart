part of 'search_cubit.dart';

class SearchState {
  final List<ProductData>  result;
  final List<ProductData>  history;
  SearchState._({this.history = const[], this.result = const[]});
  SearchState.initial() : this._();
  SearchState.set({
    required List<ProductData> result ,
    required List<ProductData>  history
  }) : this._(result: result, history: history);


  SearchState withResultOnly({
    required List<ProductData> result,
  }) => SearchState._(history: this.history, result: result );
  SearchState withHistoryOnly({
    required List<ProductData>  history,
  }) => SearchState._(history: history, result: this.result);

}

//class SearchInitial extends SearchState {}
