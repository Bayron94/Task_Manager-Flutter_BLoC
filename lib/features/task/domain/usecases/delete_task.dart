import 'package:dartz/dartz.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/repositories/repositories.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(String taskId) async {
    return await repository.deleteTask(taskId);
  }
}
