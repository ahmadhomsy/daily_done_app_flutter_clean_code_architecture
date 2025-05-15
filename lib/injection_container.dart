import 'package:daily_done/features/tasks/presentation/bloc/achievements/achievements_bloc.dart';
import 'package:daily_done/features/tasks/presentation/bloc/navigate_bar/navigate_cubit.dart';
import 'package:get_it/get_it.dart';
import 'core/data_base/sqldb.dart';
import 'features/tasks/data/data_sources/data.dart';
import 'features/tasks/data/repositories/task_repositoies_impl.dart';
import 'features/tasks/domain/repositories/task_repositories.dart';
import 'features/tasks/domain/usecases/add_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_all_task.dart';
import 'features/tasks/domain/usecases/git_achievements.dart';
import 'features/tasks/domain/usecases/update_task.dart';
import 'features/tasks/presentation/bloc/add_delete_update_task/add_delete_update_task_bloc.dart';
import 'features/tasks/presentation/bloc/task/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<SqlDb>(() => SqlDb());

  // DataSources
  sl.registerLazySingleton<Data>(() => LocalImplWithSqf(sqlDb: sl()));

  // Repository
  sl.registerLazySingleton<TaskRepositories>(
      () => TaskRepositoriesImpl(data: sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(sl()));
  sl.registerLazySingleton(() => GitAchievementsUseCase(sl()));

  // Bloc
  sl.registerFactory(() => TaskBloc(getAllTasksUseCase: sl()));
  sl.registerFactory(() => AchievementsBloc(gitAchievementsUseCase: sl()));
  sl.registerFactory(() => NavigateCubit());
  sl.registerFactory(() => AddDeleteUpdateTaskBloc(
        addTaskUseCase: sl(),
        deleteTaskUseCase: sl(),
        updateTaskUseCase: sl(),
      ));
}
