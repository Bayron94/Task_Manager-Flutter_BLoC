import 'package:dartz/dartz.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
import 'package:task_app_2024/features/task/domain/repositories/repositories.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(TaskEntity task) async {
    return await repository.updateTask(task);
  }
}
