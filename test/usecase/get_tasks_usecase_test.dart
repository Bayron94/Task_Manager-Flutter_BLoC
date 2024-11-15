import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
import 'package:task_app_2024/features/task/domain/usecases/usecases.dart';

import '../mocks.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetTasksUseCase getTasksUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getTasksUseCase = GetTasksUseCase(mockTaskRepository);
  });

  test('Debería obtener una lista de tareas del repositorio', () async {
    // Arrange
    final tasks = [
      const TaskEntity(id: '1', title: 'Test Task', isCompleted: false)
    ];
    when(mockTaskRepository.getTasks()).thenAnswer((_) async => Right(tasks));

    // Act
    final result = await getTasksUseCase();

    // Assert
    expect(result, Right(tasks));
    verify(mockTaskRepository.getTasks()).called(1);
  });

  test('Debería retornar un Failure si ocurre un error', () async {
    // Arrange
    when(mockTaskRepository.getTasks()).thenAnswer(
      (_) async => Left(ServerFailure(message: 'Error de servidor')),
    );

    // Act
    final result = await getTasksUseCase();

    // Assert
    expect(result, isA<Left>());
    verify(mockTaskRepository.getTasks()).called(1);
  });
}
