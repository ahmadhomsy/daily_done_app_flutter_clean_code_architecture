import 'package:flutter/material.dart';
import '../../features/tasks/presentation/pages/achievements_page.dart';
import '../../features/tasks/presentation/pages/task_page.dart';

final List<Widget> pages = [
  const TaskPage(),
  const AchievementsPage(),
];

enum NavTab { taskPage, achievementsPage }
