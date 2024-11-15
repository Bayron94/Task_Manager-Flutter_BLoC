import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app_2024/features/task/presentation/blocs/blocs.dart';
import 'package:task_app_2024/features/task/shared/show_custom_toast.dart';

void setupGlobalListeners(BuildContext context) {
  final taskBloc = BlocProvider.of<TaskBloc>(context);

  taskBloc.stream.listen((state) {
    if (state is TaskError) {
      showCustomToast(context, state.message, isError: true);
    }
  });
}
