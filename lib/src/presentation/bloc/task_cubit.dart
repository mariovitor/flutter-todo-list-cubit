import 'package:bloc/bloc.dart';
import 'package:todo_list_cubit/src/domain/models/task_model.dart';
import 'package:todo_list_cubit/src/domain/repositories/i_task_repository.dart';
import 'package:todo_list_cubit/src/presentation/bloc/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final ITaskRepository _taskRepository;
  TaskCubit(this._taskRepository) : super(TaskLoading());

  Future<void> loadTasks() async {
    try {
      final tasks = await _taskRepository.getTasks();
      emit(TaskLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> saveNewTask(TaskModel task) async {
    try {
      final saved = await _taskRepository.createTask(task);
      if (saved) {
        final allTasks = await _taskRepository.getTasks();
        emit(TaskLoaded(allTasks));
        return;
      }

      emit(TaskError('Erro ao salvar tarefa'));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepository.deleteTask(id);
      final allTasks = await _taskRepository.getTasks();
      emit(TaskLoaded(allTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> completeTask(String id) async {
    try {
      final success = await _taskRepository.completeTask(id);

      if (!success) throw Exception('Erro ao completar tarefa');
      final allTasks = await _taskRepository.getTasks();
      emit(TaskLoaded(allTasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
