import 'package:equatable/equatable.dart';
import 'package:flutter_local_notifications_example/data/model/work_hours.dart';

abstract class WorkHoursEvent extends Equatable {}

class GetWorkHours extends WorkHoursEvent {

  @override
  String toString() {
    return 'get';
  }
}

class ShowTempWorkHours extends WorkHoursEvent {
  final WorkHours workHours;

  ShowTempWorkHours(this.workHours);

  @override
  String toString() {
    return 'temp ${workHours.startTime}, ${workHours.endTime}';
  }
}

class SaveWorkHours extends WorkHoursEvent {
  final WorkHours workHours;

  SaveWorkHours(this.workHours);

  @override
  String toString() {
    return 'save';
  }
}
