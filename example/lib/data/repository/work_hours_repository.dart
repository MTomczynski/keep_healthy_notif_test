import 'package:flutter_local_notifications_example/data/model/work_hours.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkHoursRepository {
  WorkHoursRepository();

  Future<void> saveWorkHours(WorkHours workHours) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(KEY_START_TIME, workHours.startTime.millisecondsSinceEpoch);
    await prefs.setInt(KEY_END_TIME, workHours.endTime.millisecondsSinceEpoch);
  }

  Future<WorkHours> getWorkHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    DateTime startDate;
    if (prefs.containsKey(KEY_START_TIME)) {
      startDate =
          DateTime.fromMillisecondsSinceEpoch(prefs.getInt(KEY_START_TIME));
    } else {
      startDate = null;
    }

    DateTime endDate;
    if (prefs.containsKey(KEY_END_TIME)) {
      endDate = DateTime.fromMillisecondsSinceEpoch(prefs.getInt(KEY_END_TIME));
    } else {
      endDate = null;
    }

    return WorkHours(startDate, endDate);
  }

  final String KEY_START_TIME = "start_time";
  final String KEY_END_TIME = "end_time";
}
