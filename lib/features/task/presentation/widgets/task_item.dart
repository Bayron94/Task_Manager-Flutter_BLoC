import 'package:flutter/material.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/domain/entities/entities.dart';

class TaskItem extends StatelessWidget {
  final TaskEntity task;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        tileColor: customCardColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: GestureDetector(
          onTap: onComplete,
          child: Icon(
            task.isCompleted
                ? Icons.check_circle
                : Icons.radio_button_unchecked,
            color: task.isCompleted ? customPrimaryColor : customHintColor,
            size: 32,
          ),
        ),
        title: Text(
          task.title.toUpperCase(),
          style: textTheme.titleLarge,
        ),
        subtitle: Text(
          task.description,
          style: textTheme.bodyMedium,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: customHintColor,
            size: 24,
          ),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
