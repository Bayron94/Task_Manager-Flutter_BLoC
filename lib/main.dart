import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_app_2024/core/di/service_locator.dart';
import 'package:task_app_2024/features/task/presentation/screens/tasks_screen.dart';

import 'core/core.dart';
import 'features/task/data/models/task_model.dart';
import 'features/task/presentation/blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  // Configurar Service Locator
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TaskBloc>()..add(LoadTasks()),
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: const TasksScreen(),
      ),
    );
  }
}
