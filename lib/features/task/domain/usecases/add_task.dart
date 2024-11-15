import 'package:dartz/dartz.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
import 'package:task_app_2024/features/task/domain/repositories/repositories.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  AddTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(TaskEntity task) async {
    if (task.title.isEmpty) {
      return Left(ValidationFailure(message: 'Task title cannot be empty'));
    }
    return await repository.addTask(task);
  }
}
