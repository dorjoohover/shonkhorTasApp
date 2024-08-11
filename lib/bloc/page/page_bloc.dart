import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(const PageInitial(tabIndex: 0)) {
    on<PageEvent>((event, emit) {
      if (event is TabChange) {
        emit(PageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
