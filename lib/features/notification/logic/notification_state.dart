part of 'notification_cubit.dart';

class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class NotificationLoaded extends NotificationState {
  ProductOffers productOffersNotification;
  NotificationLoaded(this.productOffersNotification);
}
class NotificationError extends NotificationState {
  String error;
  NotificationError(this.error);
}
