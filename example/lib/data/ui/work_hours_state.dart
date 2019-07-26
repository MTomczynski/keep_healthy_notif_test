import 'dart:core';

import 'package:equatable/equatable.dart';

import '../model/work_hours.dart';

abstract class WorkHoursState extends Equatable {
  WorkHoursState([List props = const []]) : super(props);
}

class WorkHoursUninitialized extends WorkHoursState {
  @override
  String toString() {
    return 'WorkHoursUninitialized';
  }
}

class WorkHoursLoaded extends WorkHoursState {
  WorkHours workHours;

  WorkHoursLoaded(this.workHours) : super([workHours]);

  @override
  String toString() {
    return 'WorkHoursLoaded ${workHours.startTime}, ${workHours.endTime}';
  }
}
