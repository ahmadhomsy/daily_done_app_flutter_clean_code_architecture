part of 'navigate_cubit.dart';

class NavigateState {
  final NavTab selectedTab;

  const NavigateState({required this.selectedTab});

  NavigateState copyWith({NavTab? selectedTab}) {
    return NavigateState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
