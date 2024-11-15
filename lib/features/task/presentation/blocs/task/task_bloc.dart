import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';
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
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ChangeFilter>(_onChangeFilter);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await getTasksUseCase();
    result.fold(
      (failure) => emit(TaskError(failure.message)),
      (tasks) => emit(TaskLoaded(
        allTasks: tasks,
        filteredTasks: tasks,
        filter: TaskFilter.all,
      )),
    );
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(TaskLoading());

      final newTask = TaskEntity(
        id: DateTime.now().toString(),
        title: event.title,
        description: event.description,
      );

      final result = await addTaskUseCase(newTask);
      result.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) => emit(currentState.copyWith(
          allTasks: [...currentState.allTasks, newTask],
          filteredTasks: _filterTasks(
            [...currentState.allTasks, newTask],
            currentState.filter,
          ),
        )),
      );
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(TaskLoading());

      final updatedTasks = currentState.allTasks.map((task) {
        return task.id == event.id
            ? task.copyWith(isCompleted: event.isCompleted)
            : task;
      }).toList();

      final taskToUpdate =
          updatedTasks.firstWhere((task) => task.id == event.id);
      final result = await updateTaskUseCase(taskToUpdate);

      result.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) => emit(currentState.copyWith(
          allTasks: updatedTasks,
          filteredTasks: _filterTasks(updatedTasks, currentState.filter),
        )),
      );
    }
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;
      emit(TaskLoading());

      final updatedTasks =
          currentState.allTasks.where((task) => task.id != event.id).toList();

      final result = await deleteTaskUseCase(event.id);
      result.fold(
        (failure) => emit(TaskError(failure.message)),
        (_) => emit(currentState.copyWith(
          allTasks: updatedTasks,
          filteredTasks: _filterTasks(updatedTasks, currentState.filter),
        )),
      );
    }
  }

  void _onChangeFilter(ChangeFilter event, Emitter<TaskState> emit) {
    if (state is TaskLoaded) {
      final currentState = state as TaskLoaded;

      final filteredTasks = _filterTasks(currentState.allTasks, event.filter);

      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        filter: event.filter,
      ));
    }
  }

  List<TaskEntity> _filterTasks(List<TaskEntity> tasks, TaskFilter filter) {
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
}
