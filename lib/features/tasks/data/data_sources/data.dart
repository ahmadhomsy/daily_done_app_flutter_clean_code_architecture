import 'package:daily_done/core/data_base/sqldb.dart';
import 'package:daily_done/features/tasks/data/models/task_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';

abstract class Data {
  Future<List<TaskModel>> getCashedTasks();
  Future<Unit> addTask(TaskModel taskModel);
  Future<Unit> updateTask(TaskModel taskModel);
  Future<Unit> deleteTask(int id);
  Future<Map<String, int>> gitAchievements();
}

class LocalImplWithSqf extends Data {
  final SqlDb sqlDb;

  LocalImplWithSqf({required this.sqlDb});
  @override
  Future<List<TaskModel>> getCashedTasks() async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tomorrowStart = todayStart.add(const Duration(days: 1));

    final data = await sqlDb.readData('''
    SELECT * FROM tasks 
    WHERE isComplete = 0 
    AND dateTime >= '$todayStart' 
    AND dateTime < '$tomorrowStart'
  ''');

    if (data.isNotEmpty) {
      return data.map((task) => TaskModel.fromMap(task)).toList();
    } else {
      throw EmptyCashException();
    }
  }

  @override
  Future<Unit> addTask(TaskModel taskModel) async {
    try {
      await sqlDb.insertData(
        '''
    INSERT INTO tasks (task, description, dateTime, isComplete)
    VALUES ('${taskModel.task}','${taskModel.description}','${taskModel.dateTime}', '${taskModel.isComplete ? 1 : 0}')
  ''',
      );
      return unit;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Unit> deleteTask(int id) async {
    try {
      await sqlDb.deleteData('''
    DELETE FROM tasks WHERE id = '$id'
  ''');
      return unit;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Unit> updateTask(TaskModel taskModel) async {
    try {
      await sqlDb.updateData(
        '''
  UPDATE tasks
  SET task = ?, 
      description = ?, 
      dateTime = ?, 
      isComplete = ?
  WHERE id = ?
  ''',
        [
          taskModel.task,
          taskModel.description,
          taskModel.dateTime.toString(),
          taskModel.isComplete ? 1 : 0,
          taskModel.id,
        ],
      );
      return unit;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Map<String, int>> gitAchievements() async {
    final data = await sqlDb.readData('SELECT isComplete FROM tasks');
    if (data.isNotEmpty) {
      List<int> isCompleteList =
          data.map((row) => row['isComplete'] as int).toList();
      int numbCompleter = isCompleteList.where((e) => e == 1).length;
      int numbInCompleter = isCompleteList.where((e) => e == 0).length;
      return {
        'numbCompleter': numbCompleter,
        'numbInCompleter': numbInCompleter,
      };
    } else {
      throw EmptyCashException();
    }
  }
}
