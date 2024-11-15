import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/presentation/blocs/blocs.dart';
import 'package:task_app_2024/features/task/presentation/widgets/widgets.dart';
import 'package:task_app_2024/features/task/shared/show_custom_toast.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskError) {
                showCustomToast(context, state.message, isError: true);
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoaded) {
                    return TaskFilterChips(
                      selectedFilter: state.filter,
                      onFilterSelected: (filter) =>
                          context.read<TaskBloc>().add(ChangeFilter(filter)),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 16),
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
                            onComplete: () => context
                                .read<TaskBloc>()
                                .add(UpdateTask(task.id, !task.isCompleted)),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: customPrimaryColor,
        onPressed: () => _showCreateTaskBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: 'Eliminar Tarea',
        content: '¿Estás seguro de que deseas eliminar esta tarea?',
        onConfirm: () {
          context.read<TaskBloc>().add(DeleteTask(taskId));
        },
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
      builder: (_) => CreateTaskBottomSheet(
        onTaskCreated: (title, description) {
          context.read<TaskBloc>().add(
                AddTask(title, description: description),
              );
        },
      ),
    );
  }
}
