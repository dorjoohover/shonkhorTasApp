part of 'page_bloc.dart';

@immutable
sealed class PageState {
  final int tabIndex;
  const PageState({required this.tabIndex});
}

final class PageInitial extends PageState {
  const PageInitial({required super.tabIndex});
}
