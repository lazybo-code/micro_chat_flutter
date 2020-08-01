import 'package:event_bus/event_bus.dart';
EventBus routerEventBus = EventBus();

class RouterSwitchEvent {
  String router;

  RouterSwitchEvent(this.router);
}