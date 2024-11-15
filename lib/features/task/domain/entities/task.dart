import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final String description;

  const TaskEntity({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.description = '',
  });

  @override
  List<Object?> get props => [id, title, isCompleted, description];
}
