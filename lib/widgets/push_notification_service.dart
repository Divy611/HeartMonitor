import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:heartmonitor/models/push_notification_model.dart';
import 'package:rxdart/rxdart.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging;
  PushNotificationService(this._firebaseMessaging) {
    initializeMessages();
  }
  late PublishSubject<PushNotificationModel> _pushNotificationSubject;
  Stream<PushNotificationModel> get pushNotificationResponseStream =>
      _pushNotificationSubject.stream;
  // ignore: unused_field,cancel_subscription
  late StreamSubscription<RemoteMessage> _backgroundMessageSubscription;
  void initializeMessages() {
    configure();
  }

  void dispose() {
    _backgroundMessageSubscription.cancel();
  }

  void configure() async {
    _pushNotificationSubject = PublishSubject<PushNotificationModel>();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        try {
          myBackgroundMessageHandler(message.data, onMessage: true);
        } catch (e) {}
      },
    );
    //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage().then(
      (event) {
        if (event != null) {
          try {
            myBackgroundMessageHandler(event.data, onLaunch: true);
          } catch (e) {}
        }
      },
    );
    _backgroundMessageSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage? event) {
        if (event != null) {
          try {
            myBackgroundMessageHandler(event.data, onLaunch: true);
          } catch (e) {}
        }
      },
    );
  }

  Future<String?> getDeviceToken() async {
    final token = await _firebaseMessaging.getToken();
    return token;
  }

  void myBackgroundMessageHandler(Map<String, dynamic> message,
      {bool onBackGround = false,
      bool onLaunch = false,
      bool onMessage = false,
      bool onResume = false}) async {
    try {
      if (!onMessage) {
        PushNotificationModel model = PushNotificationModel.fromJson(message);
        _pushNotificationSubject.add(model);
      }
    } catch (error) {}
  }
}
