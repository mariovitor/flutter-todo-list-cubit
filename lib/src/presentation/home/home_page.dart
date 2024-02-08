import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_cubit/src/core/locator.dart';
import 'package:todo_list_cubit/src/domain/models/task_model.dart';
import 'package:todo_list_cubit/src/presentation/bloc/task_cubit.dart';
import 'package:todo_list_cubit/src/presentation/bloc/task_state.dart';
import 'package:todo_list_cubit/src/presentation/home/dialogs/add_task_dialog.dart';
import 'package:todo_list_cubit/src/presentation/home/views/task_loaded_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = getIt<TaskCubit>();

  @override
  void initState() {
    super.initState();
    cubit.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Minhas tarefas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<TaskModel>(
              context: context,
              builder: (context) {
                return const AddTaskDialog();
              }).then((value) {
            if (value != null) {
              cubit.saveNewTask(value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => cubit,
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return switch (state) {
              TaskLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              TaskError() => Center(
                  child: Text(state.message),
                ),
              TaskLoaded() when state.tasks.isEmpty => const Center(
                  child: Text(
                    'Nenhuma tarefa cadastrada',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              TaskLoaded() => TaskLoadedView(tasks: state.tasks),
            };
          },
        ),
      ),
    );
  }
}
