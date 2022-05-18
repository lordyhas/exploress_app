library data.app_bloc;

export 'app_bloc/search_bloc/search_cubit.dart';
export 'map_data/maps.dart';
export 'app_bloc/filter_bloc/filter_cubit.dart';
export 'package:exploress_repository/exploress_bloc.dart';

/// Custom [BlocObserver] which observes all bloc and cubit instances.
///

/*
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(bloc.toString() + " => onEvent() : $event");
    super.onEvent(bloc, event);
  }

  /*@override
  void onChange(Cubit cubit, Change change) {
    print(cubit.toString() + " => onChange() : $change");
    super.onChange(cubit, change);
  }*/

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(bloc.toString() + " => onTransition()  : $transition");
    super.onTransition(bloc, transition);
  }

 /* @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print("onError()  : $error");
    //print(error);
    super.onError(bloc, error, stackTrace);
  }*/

}
*/

/**void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}*/


/*class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Styles(),
      child: BlocBuilder<Styles, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            home: BlocProvider(
              create: (_) => CounterBloc(),
              child: CounterPage(),
            ),
          );
        },
      ),
    );
  }
}*/

/// A [StatelessWidget] which demonstrates
/// how to consume and interact with a [CounterBloc].
/*class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterBloc, int>(
        builder: (_, count) {
          return Center(
            child: Text('$count', style: Theme.of(context).textTheme.headline1),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.increment),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () =>
                  context.bloc<CounterBloc>().add(CounterEvent.decrement),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.brightness_6),
              onPressed: () => context.bloc<Styles>().toggleTheme(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.error),
              onPressed: () => context.bloc<CounterBloc>().add(null),
            ),
          ),
        ],
      ),
    );
  }
}*/

/*
/// Event being processed by [CounterBloc].
enum CounterEvent {
  /// Notifies bloc to increment state.
  increment,

  /// Notifies bloc to decrement state.
  decrement
}

/// {@template counter_bloc}
/// A simple [Bloc] which manages an `int` as its state.
/// {@endtemplate}
class CounterBloc extends Bloc<CounterEvent, int> {
  /// {@macro counter_bloc}
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}

*/