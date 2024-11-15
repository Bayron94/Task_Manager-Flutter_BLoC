import 'package:dartz/dartz.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/data/sources/sources.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
import 'package:task_app_2024/features/task/domain/repositories/task_repository.dart';
import 'package:task_app_2024/features/task/shared/shared.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks() async {
    try {
      final tasks = await localDataSource.getTasks();
      return Right(tasks.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to fetch tasks'));
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      final model = task.toModel();
      await localDataSource.addTask(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to add task'));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    try {
      final model = task.toModel();
      await localDataSource.updateTask(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to update task'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await localDataSource.deleteTask(taskId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(message: 'Failed to delete task'));
    }
  }
}
