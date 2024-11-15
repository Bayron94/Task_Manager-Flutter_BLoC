import 'package:flutter/material.dart';
import 'package:task_app_2024/core/core.dart';
import 'package:task_app_2024/features/task/shared/shared.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  final void Function(String title, String description) onTaskCreated;

  const CreateTaskBottomSheet({super.key, required this.onTaskCreated});

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  void _createTask() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Enviar el evento para crear la tarea
      widget.onTaskCreated(
        _titleController.text,
        _descriptionController.text,
      );

      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isLoading = false);
        showCustomToast(context, "Tarea creada exitosamente");
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(
        top: 32,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crear Tarea',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 1,
              color: customPrimaryColor,
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                labelStyle: textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: customHintColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El título es requerido';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción (opcional)',
                labelStyle: textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: customHintColor),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 48),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _createTask,
                      child: Text(
                        'Crear Tarea'.toUpperCase(),
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
