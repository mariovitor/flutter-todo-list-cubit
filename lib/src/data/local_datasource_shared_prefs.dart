import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_cubit/src/data/i_local_datasource.dart';

class LocalDataSourceSharedPrefs implements ILocalDatasource {
  final SharedPreferences prefs;
  LocalDataSourceSharedPrefs(this.prefs);
  @override
  Future<List<String>?> getTasksJson() async {
    try {
      return prefs.getStringList(ILocalDatasource.tasksKey);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> saveTasksJson(List<String> tasks) async {
    try {
      return prefs.setStringList(ILocalDatasource.tasksKey, tasks);
    } catch (e) {
      rethrow;
    }
  }
}
