import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:task_app_2024/features/task/data/models/models.dart';
import 'package:task_app_2024/features/task/data/repositories/repositories.dart';
import 'package:task_app_2024/features/task/data/sources/sources.dart';
import 'package:task_app_2024/features/task/domain/repositories/repositories.dart';
import 'package:task_app_2024/features/task/domain/usecases/usecases.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Registrar y abrir la Box de Hive
  final taskBox = await Hive.openBox<TaskModel>('tasksBox');
  getIt.registerSingleton<Box<TaskModel>>(taskBox);

  // Sources
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(getIt<Box<TaskModel>>()),
  );

  // Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt<LocalDataSource>()),
  );

  // Use-Cases
  getIt.registerLazySingleton(() => GetTasksUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => DeleteTaskUseCase(getIt<TaskRepository>()));
  getIt.registerLazySingleton(() => UpdateTaskUseCase(getIt<TaskRepository>()));
}
