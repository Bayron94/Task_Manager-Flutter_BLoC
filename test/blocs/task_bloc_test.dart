import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
import 'package:task_app_2024/features/task/domain/usecases/usecases.dart';
import 'package:task_app_2024/features/task/presentation/blocs/blocs.dart';

import '../mocks.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetTasksUseCase getTasksUseCase;
  late AddTaskUseCase addTaskUseCase;
  late TaskBloc taskBloc;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getTasksUseCase = GetTasksUseCase(mockTaskRepository);
    addTaskUseCase = AddTaskUseCase(mockTaskRepository);
    taskBloc = TaskBloc(
      getTasksUseCase: getTasksUseCase,
      addTaskUseCase: addTaskUseCase,
      updateTaskUseCase: UpdateTaskUseCase(mockTaskRepository),
      deleteTaskUseCase: DeleteTaskUseCase(mockTaskRepository),
    );
  });

  blocTest<TaskBloc, TaskState>(
    'Debería emitir [TaskLoading, TaskLoaded] al cargar tareas exitosamente',
    build: () {
      when(mockTaskRepository.getTasks()).thenAnswer(
        (_) async => const Right([
          TaskEntity(id: '1', title: 'Task 1', isCompleted: false),
        ]),
      );
      return taskBloc;
    },
    act: (bloc) => bloc.add(LoadTasks()),
    expect: () => [
      TaskLoading(),
      const TaskLoaded(
        allTasks: [TaskEntity(id: '1', title: 'Task 1', isCompleted: false)],
        filteredTasks: [
          TaskEntity(id: '1', title: 'Task 1', isCompleted: false)
        ],
        filter: TaskFilter.all,
      ),
    ],
    verify: (_) {
      verify(mockTaskRepository.getTasks()).called(1);
    },
  );

  blocTest<TaskBloc, TaskState>(
    'Debería emitir [TaskError] si ocurre un error al cargar tareas',
    build: () {
      when(mockTaskRepository.getTasks()).thenAnswer(
        (_) async => Left(ServerFailure(message: 'Error de servidor')),
      );
      return taskBloc;
    },
    act: (bloc) => bloc.add(LoadTasks()),
    expect: () => [
      TaskLoading(),
      const TaskError('Error de servidor'),
    ],
    verify: (_) {
      verify(mockTaskRepository.getTasks()).called(1);
    },
  );
}
