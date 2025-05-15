import 'package:daily_done/features/tasks/presentation/bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import 'package:daily_done/features/tasks/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/snackbar_message.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/task.dart';
import '../widgets/add_update/form_widget.dart';

class AddUpdateTaskPage extends StatelessWidget {
  final Tasks? task;
  final bool isUpdateTask;

  const AddUpdateTaskPage({super.key, required this.isUpdateTask, this.task});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddDeleteUpdateTaskBloc>(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(isUpdateTask ? "تعديل المهمة" : "اضافة مهمة"),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              BlocConsumer<AddDeleteUpdateTaskBloc, AddDeleteUpdateTaskState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateTaskState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                    (route) => false);
              } else if (state is ErrorAddDeleteUpdateTaskState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateTaskState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdateTask: isUpdateTask, task: isUpdateTask ? task : null);
            },
          )),
    );
  }
}
