import 'package:bloc/bloc.dart';

import '../../../../../core/static/static.dart';

part 'navigate_state.dart';

class NavigateCubit extends Cubit<NavigateState> {
  NavigateCubit() : super(const NavigateState(selectedTab: NavTab.taskPage));

  void changeTab(NavTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
