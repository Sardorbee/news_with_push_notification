part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable{}

class SendNotification extends NotificationEvent {

  @override
  List<Object?> get props => [];
}
class FetchLocalNotification extends NotificationEvent {

  @override
  List<Object?> get props => [];
}
