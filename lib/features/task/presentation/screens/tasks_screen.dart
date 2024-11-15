import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/presentation/blocs/blocs.dart';
import 'package:task_app_2024/features/task/presentation/widgets/widgets.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: customBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
              bottom: 10,
            ),
            child: Column(
              children: [
                Center(
                  child: Text('Tus Tareas', style: textTheme.displayLarge),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: customPrimaryColor,
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: TaskFilter.values.map((filter) {
                          final isSelected = state.filter == filter;

                          return ChoiceChip(
                            label: Text(
                              filter == TaskFilter.all
                                  ? 'Todas'
                                  : filter == TaskFilter.completed
                                      ? 'Completadas'
                                      : 'No Completadas',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : customPrimaryColor,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                context
                                    .read<TaskBloc>()
                                    .add(ChangeFilter(filter));
                              }
                            },
                            selectedColor: customPrimaryColor,
                            backgroundColor: customCardColor,
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.white
                                  : customPrimaryColor,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Expanded(
                child: BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    if (state is TaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TaskError) {
                      return Center(child: Text(state.message));
                    } else if (state is TaskLoaded) {
                      if (state.filteredTasks.isEmpty) {
                        return const Center(
                          child: Text('No hay tareas para mostrar'),
                        );
                      }
                      return ListView.builder(
                        itemCount: state.filteredTasks.length,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemBuilder: (context, index) {
                          final task = state.filteredTasks[index];
                          return TaskItem(
                            task: task,
                            onDelete: () => _confirmDelete(context, task.id),
                            onComplete: () => _confirmComplete(
                              context,
                              task.id,
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: customPrimaryColor,
          onPressed: () => _showCreateTaskBottomSheet(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showCreateTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const CreateTaskBottomSheet(),
    );
  }

  void _confirmDelete(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: customCardColor,
          surfaceTintColor: customCardColor,
          backgroundColor: customCardColor,
          title: Text(
            'Eliminar Tarea',
            style: textTheme.titleLarge,
          ),
          content: Text(
            '¿Estás seguro de que deseas eliminar esta tarea?',
            style: textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: customPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                context.read<TaskBloc>().add(DeleteTask(taskId));
                Navigator.of(context).pop();
              },
              child: Text(
                'Eliminar',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmComplete(BuildContext context, String taskId) {
    Fluttertoast.showToast(
      msg: "¡Tarea completada!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: customPrimaryColor,
      textColor: Colors.white,
      fontSize: 16,
    );
    context.read<TaskBloc>().add(UpdateTask(taskId, true));
  }
}
