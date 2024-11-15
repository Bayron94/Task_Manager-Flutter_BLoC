import 'package:flutter/material.dart';
import 'package:task_app_2024/core/theme/theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(title, style: textTheme.titleLarge),
      content: Text(content, style: textTheme.bodyMedium),
      shadowColor: customCardColor,
      surfaceTintColor: customCardColor,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            'Confirmar',
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
