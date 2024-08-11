part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final List<Service>? services;
  const HomeState({this.services});
}

final class HomeInitial extends HomeState {
  const HomeInitial({ super.services});
}

final class HomeLoading extends HomeState {
  const HomeLoading({super.services});
}

final class HomeFailure extends HomeState {
  final String error;

  const HomeFailure({super.services, required this.error});
}

final class ChoseService extends HomeState {
  final String? id;

  const ChoseService({this.id});
}

final class SuccessOrder extends HomeState {
  final int status;
  final String message;
  final String id;
  final bool success;
  const SuccessOrder(
      {required this.id,
      required this.message,
      required this.status,
      required this.success});
}
