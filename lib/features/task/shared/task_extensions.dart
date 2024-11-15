import 'package:task_app_2024/features/task/data/models/models.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';

extension TaskModelMapper on TaskModel {
  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      isCompleted: isCompleted,
      description: description,
    );
  }
}

extension TaskEntityMapper on TaskEntity {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      isCompleted: isCompleted,
      description: description,
    );
  }
}
