import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/static/static.dart';
import '../../../../injection_container.dart';
import '../bloc/navigate_bar/navigate_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NavigateCubit>(),
      child: BlocBuilder<NavigateCubit, NavigateState>(
        builder: (context, state) {
          int index = NavTab.values.indexOf(state.selectedTab);
          return Scaffold(
            body: pages[index],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              onTap: (index) =>
                  context.read<NavigateCubit>().changeTab(NavTab.values[index]),
              items: _buildBottomNavigationBar(),
            ),
          );
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBar() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'الرئيسية',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.emoji_events),
        label: 'الانجازات',
      ),
    ];
  }
}
