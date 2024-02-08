import 'package:flutter/material.dart';

class DeleteTaskDialog extends StatelessWidget {
  const DeleteTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      contentPadding: const EdgeInsets.all(24),
      content: const Text(
        'Deseja excluir a tarefa?',
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Excluir')),
      ],
    );
  }
}
