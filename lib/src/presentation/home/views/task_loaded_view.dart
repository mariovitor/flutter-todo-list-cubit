// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_list_cubit/src/domain/models/task_model.dart';
import 'package:todo_list_cubit/src/presentation/bloc/task_cubit.dart';
import 'package:todo_list_cubit/src/presentation/home/dialogs/delte_task_dialog.dart';
import 'package:todo_list_cubit/src/presentation/home/widgets/bump_button.dart';

class TaskLoadedView extends StatelessWidget {
  const TaskLoadedView({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskCubit>();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(tasks[i].name),
          subtitle: Text(tasks[i].description),
          leading: SizedBox(
            width: 30,
            child: tasks[i].isCompleted
                ? const FittedBox(
                    child: Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  )
                : null,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!tasks[i].isCompleted)
                BumpButton(
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 28,
                  ),
                  onTap: () {
                    cubit.completeTask(tasks[i].id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tarefa concluída'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              IconButton(
                onPressed: () {
                  showAdaptiveDialog<bool>(
                    context: context,
                    builder: (context) {
                      return const DeleteTaskDialog();
                    },
                  ).then((delete) {
                    if (delete == true) {
                      cubit.deleteTask(tasks[i].id);
                    }
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
