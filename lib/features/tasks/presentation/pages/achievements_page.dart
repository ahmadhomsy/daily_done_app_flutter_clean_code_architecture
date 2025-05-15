import 'package:daily_done/features/tasks/presentation/bloc/achievements/achievements_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../widgets/achievements/achievements_widget.dart';
import '../widgets/task/error_message_widget.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AchievementsBloc>()..add(GetAchievementsEvent()),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("الانجازات"),
      centerTitle: true,
      backgroundColor: Colors.purple,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<AchievementsBloc, AchievementsState>(
      builder: (context, state) {
        if (state is LoadingAchievementsState) {
          return const LoadingWidget();
        } else if (state is LoadedAchievementsState) {
          return AchievementsWidget(achievements: state.achievements);
        } else if (state is ErrorAchievementsState) {
          return ErrorMessageWidget(message: state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
