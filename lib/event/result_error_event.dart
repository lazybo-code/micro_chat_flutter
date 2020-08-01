import 'package:event_bus/event_bus.dart';
EventBus resultErrorEventBus = EventBus();

class AuthErrorEvent {
  String message;
  int code;

  AuthErrorEvent(this.code, this.message);
}