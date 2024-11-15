import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
import 'package:task_app_2024/features/task/domain/entities/task.dart';
import 'package:task_app_2024/features/task/domain/usecases/usecases.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskBloc({
    required this.getTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
    required this.deleteTaskUseCase,
  }) : super(TaskInitial()) {
    List<TaskEntity> filterTasks(List<TaskEntity> tasks, TaskFilter filter) {
      switch (filter) {
        case TaskFilter.completed:
          return tasks.where((task) => task.isCompleted).toList();
        case TaskFilter.notCompleted:
          return tasks.where((task) => !task.isCompleted).toList();
        case TaskFilter.all:
        default:
          return tasks;
      }
    }

    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());

      final result = await getTasksUseCase();
      result.fold(
        (failure) => emit(TaskError(failure.message)),
        (tasks) {
          emit(TaskLoaded(
            allTasks: tasks,
            filteredTasks: tasks,
            filter: TaskFilter.all,
          ));
        },
      );
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading());

      final result = await addTaskUseCase(
        TaskEntity(
          id: DateTime.now().toString(),
          title: event.title,
          description: event.description,
        ),
      );
      result.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) => add(LoadTasks()),
      );
    });

    on<UpdateTask>((event, emit) async {
      final currentState = state;
      if (currentState is TaskLoaded) {
        emit(TaskLoading());

        // Busca la tarea original en allTasks
        final updatedTasks = currentState.allTasks.map((task) {
          if (task.id == event.id) {
            return task.copyWith(isCompleted: event.isCompleted);
          }
          return task;
        }).toList();

        // Llama al caso de uso para actualizar en el almacenamiento
        final taskToUpdate =
            updatedTasks.firstWhere((task) => task.id == event.id);
        final result = await updateTaskUseCase(taskToUpdate);

        result.fold(
          (failure) => emit(TaskError(failure.message)),
          (_) {
            // Aplica el filtro actual para actualizar filteredTasks
            final filteredTasks = filterTasks(
              updatedTasks,
              currentState.filter,
            );

            // Emite el nuevo estado con las listas actualizadas
            emit(currentState.copyWith(
              allTasks: updatedTasks,
              filteredTasks: filteredTasks,
            ));
          },
        );
      } else {
        emit(TaskError('Estado actual inválido para actualizar la tarea'));
      }
    });

    on<DeleteTask>((event, emit) async {
      final currentState = state;
      if (currentState is TaskLoaded) {
        emit(TaskLoading());

        // Filtra la tarea a eliminar de allTasks
        final updatedTasks =
            currentState.allTasks.where((task) => task.id != event.id).toList();

        // Llama al caso de uso para eliminar la tarea en el almacenamiento
        final result = await deleteTaskUseCase(event.id);

        result.fold(
          (failure) => emit(TaskError(failure.message)),
          (_) {
            // Aplica el filtro actual para actualizar filteredTasks
            final filteredTasks =
                filterTasks(updatedTasks, currentState.filter);

            // Emite el nuevo estado con las listas actualizadas
            emit(currentState.copyWith(
              allTasks: updatedTasks,
              filteredTasks: filteredTasks,
            ));
          },
        );
      } else {
        emit(TaskError('Estado actual inválido para eliminar la tarea'));
      }
    });

    on<ChangeFilter>((event, emit) {
      final currentState = state;
      if (currentState is TaskLoaded) {
        List<TaskEntity> filteredTasks;

        switch (event.filter) {
          case TaskFilter.completed:
            filteredTasks = currentState.allTasks
                .where((task) => task.isCompleted)
                .toList();
            break;
          case TaskFilter.notCompleted:
            filteredTasks = currentState.allTasks
                .where((task) => !task.isCompleted)
                .toList();
            break;
          case TaskFilter.all:
          default:
            filteredTasks = currentState.allTasks;
            break;
        }

        emit(currentState.copyWith(
            filteredTasks: filteredTasks, filter: event.filter));
      }
    });
  }
}
