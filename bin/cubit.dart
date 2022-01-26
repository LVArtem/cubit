import 'package:bloc/bloc.dart';

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));
  }
}

Future<void> main(List<String> args) async {
  final bloc = CounterBloc();

  final streamSubscription = bloc.stream.listen(print);
  print(bloc.state);
  bloc.add(Increment());
  bloc.add(Increment());

  bloc.add(Decrement());
  bloc.add(Decrement());

  await Future.delayed(Duration
      .zero); //! we use this to not cancel the subscription immediately down here

  await streamSubscription.cancel();
  await bloc.close();
}

// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
//
//   void increment() => emit(state + 1);
//   void decrement() => emit(state - 1);
// }
//
// Future<void> main(List<String> args) async {
//   final cubit = CounterCubit();
//
//   final streamSubscription = cubit.stream.listen(
//       print); //! this subscribes to the cubit state stream and prints the state values emitted by it
//   // (подписывается на поток состояния cubit и печатает значения состояния, испускаемые им)
//
//   cubit.increment();
//   cubit.increment();
//   cubit.increment();
//   cubit.increment();
//   cubit.decrement();
//
//   await Future.delayed(Duration
//       .zero); //! we use this to not cancel the subscription immediately down here (мы используем это, чтобы не отменять подписку немедленно.)
//
//   await streamSubscription.cancel();
//   await cubit.close();
// }
