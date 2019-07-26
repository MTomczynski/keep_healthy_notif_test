import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications_example/data/model/notification_rule.dart';
import 'package:flutter_local_notifications_example/data/repository/work_hours_repository.dart';
import 'package:flutter_local_notifications_example/data/ui/work_hours_event.dart';
import 'package:flutter_local_notifications_example/data/ui/work_hours_state.dart';

import '../notifications_manager.dart';

class WorkHoursBloc extends Bloc<WorkHoursEvent, WorkHoursState> {
  final WorkHoursRepository workHoursRepository;
  final NotificationManager notificationManager = NotificationManager();

  WorkHoursBloc(this.workHoursRepository);

  @override
  WorkHoursState get initialState => WorkHoursUninitialized();

  @override
  Stream<WorkHoursState> mapEventToState(WorkHoursEvent event) async* {
    if (event is GetWorkHours) {
      final workHours = await workHoursRepository.getWorkHours();
      if (workHours.startTime == null || workHours.endTime == null) {
        yield WorkHoursUninitialized();
      } else {
        yield WorkHoursLoaded(workHours);
      }
      return;
    } else if (event is SaveWorkHours) {
      await workHoursRepository.saveWorkHours(event.workHours);
      notificationManager.clearNotifications();
      NotificationRule rule =
          NotificationRule(1, "Test rule", "Testing", "Just testing", 1);
      notificationManager.setupDailyNotifications(event.workHours, rule);
      //await notificationManager.showNotification();
      yield WorkHoursLoaded(event.workHours);
      return;
    } else if (event is ShowTempWorkHours) {
      yield WorkHoursLoaded(event.workHours);
      return;
    }
  }
}
