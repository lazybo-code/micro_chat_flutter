import 'package:event_bus/event_bus.dart';
EventBus socketEventBus = EventBus();

class SocketConnectEvent {
  String token;

  SocketConnectEvent(this.token);
}