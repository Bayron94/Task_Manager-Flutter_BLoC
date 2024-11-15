import 'package:flutter/material.dart';
import 'package:task_app_2024/core/theme/theme.dart';
import 'package:task_app_2024/features/task/presentation/blocs/blocs.dart';

class TaskFilterChips extends StatelessWidget {
  final TaskFilter selectedFilter;
  final ValueChanged<TaskFilter> onFilterSelected;

  const TaskFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: TaskFilter.values.map((filter) {
        final isSelected = selectedFilter == filter;
        final filterText = filter == TaskFilter.all
            ? 'Todas'
            : filter == TaskFilter.completed
                ? 'Completadas'
                : 'No Completadas';

        return ChoiceChip(
          label: Text(
            filterText,
            style: TextStyle(
              color: isSelected ? Colors.white : customPrimaryColor,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onFilterSelected(filter),
          selectedColor: customPrimaryColor,
          backgroundColor: Theme.of(context).cardColor,
          side: BorderSide(
            color: isSelected ? Colors.white : customPrimaryColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }).toList(),
    );
  }
}
