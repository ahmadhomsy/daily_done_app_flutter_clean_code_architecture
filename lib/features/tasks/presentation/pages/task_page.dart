import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import '../bloc/task/task_bloc.dart';
import '../widgets/task/error_message_widget.dart';
import '../widgets/task/floating_button.dart';
import '../widgets/task/task_widget.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<TaskBloc>()..add(GetAllTasksEvent()),
        ),
        BlocProvider(
          create: (context) => sl<AddDeleteUpdateTaskBloc>(),
        ),
      ],
      child: Scaffold(
        floatingActionButton: const FloatingButton(),
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("الصفحة الرئيسية"),
      centerTitle: true,
      backgroundColor: Colors.purple,
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is LoadingTasksState) {
          return const LoadingWidget();
        } else if (state is LoadedTasksState) {
          return TaskWidget(tasks: state.task);
        } else if (state is ErrorTasksState) {
          return ErrorMessageWidget(message: state.message);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
