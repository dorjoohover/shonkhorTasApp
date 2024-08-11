part of 'page_bloc.dart';

@immutable
sealed class PageEvent {}

class TabChange extends PageEvent {
  final int tabIndex;
  TabChange({required this.tabIndex});
}
