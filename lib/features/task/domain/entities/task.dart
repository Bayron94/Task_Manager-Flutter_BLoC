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

  TaskEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
