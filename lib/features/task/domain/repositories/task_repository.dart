import 'package:dartz/dartz.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks();
  Future<Either<Failure, void>> addTask(TaskEntity task);
  Future<Either<Failure, void>> updateTask(TaskEntity task);
  Future<Either<Failure, void>> deleteTask(String taskId);
}
