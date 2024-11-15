part of 'task_bloc.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final String title;
  final String description;

  AddTask(this.title, {this.description = ''});
}

class UpdateTask extends TaskEvent {
  final String id;
  final bool isCompleted;

  UpdateTask(this.id, this.isCompleted);
}

class DeleteTask extends TaskEvent {
  final String id;

  DeleteTask(this.id);
}

class ChangeFilter extends TaskEvent {
  final TaskFilter filter;

  ChangeFilter(this.filter);

  List<Object?> get props => [filter];
}
