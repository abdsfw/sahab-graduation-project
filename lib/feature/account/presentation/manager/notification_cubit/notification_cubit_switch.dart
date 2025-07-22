import 'package:flutter_bloc/flutter_bloc.dart';

enum NotificationStatus { enabled, disabled }

class NotificationCubitSwitch extends Cubit<NotificationStatus> {
  NotificationCubitSwitch() : super(NotificationStatus.enabled);

  void toggleNotification(bool isEnabled) {
    emit(isEnabled ? NotificationStatus.enabled : NotificationStatus.disabled);
  }
}
