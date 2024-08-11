part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
final class HomeGetService extends HomeEvent {}
final class CreateOrder extends HomeEvent {
  final String id;
  CreateOrder({required this.id});
}
