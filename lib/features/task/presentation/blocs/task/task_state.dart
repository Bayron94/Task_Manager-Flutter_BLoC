part of 'task_bloc.dart';

enum TaskFilter { all, completed, notCompleted }

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> allTasks;
  final List<TaskEntity> filteredTasks;
  final TaskFilter filter;

  const TaskLoaded({
    required this.allTasks,
    required this.filteredTasks,
    this.filter = TaskFilter.all,
  });

  @override
  List<Object?> get props => [allTasks, filteredTasks, filter];

  TaskLoaded copyWith({
    List<TaskEntity>? allTasks,
    List<TaskEntity>? filteredTasks,
    TaskFilter? filter,
  }) {
    return TaskLoaded(
      allTasks: allTasks ?? this.allTasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      filter: filter ?? this.filter,
    );
  }
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
