import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_cubit/src/data/i_local_datasource.dart';
import 'package:todo_list_cubit/src/data/local_datasource_shared_prefs.dart';
import 'package:todo_list_cubit/src/data/repositories/task_repository.dart';
import 'package:todo_list_cubit/src/domain/repositories/i_task_repository.dart';
import 'package:todo_list_cubit/src/presentation/bloc/task_cubit.dart';

GetIt get getIt => GetIt.instance;

abstract class Locator {
  static Future<void> init() async {
    await initDatasources();
    initRepositories();
    initCubits();
  }

  static Future<void> initDatasources() async {
    final prefs = await SharedPreferences.getInstance();

    getIt.registerFactory<ILocalDatasource>(
        () => LocalDataSourceSharedPrefs(prefs));
  }

  static void initRepositories() {
    getIt.registerFactory<ITaskRepository>(() => TaskRepository(getIt()));
  }

  static void initCubits() {
    getIt.registerLazySingleton<TaskCubit>(() => TaskCubit(getIt()));
  }
}
