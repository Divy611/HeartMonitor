import 'package:flutter/material.dart';
import 'package:heartmonitor/ui/pages/Home/allreadings/readings.dart';
import 'package:provider/provider.dart';
import 'package:heartmonitor/state/appState.dart';
import 'package:heartmonitor/ui/pages/Home/home.dart';
import 'package:heartmonitor/widgets/bottomMenuBar/bottomMenuBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int pageIndex = 0;
  // ignore: cancel_subscriptions
  //late StreamSubscription<PushNotificationModel> pushNotificationSubscription;
  @override
  void initState() {
    initDynamicLinks();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var state = Provider.of<AppState>(context, listen: false);
        state.setPageIndex = 0;
        //initTweets();
        //initProfile();
        //initSearch();
        //initNotification();
        initChat();
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //void initTweets() {
  //  var state = Provider.of<FeedState>(context, listen: false);
  //  state.databaseInit();
  //  state.getDataFromDatabase();
  //}

  //void initProfile() {
  //  var state = Provider.of<AuthState>(context, listen: false);
  //  state.databaseInit();
  //}

  //void initSearch() {
  //  var searchState = Provider.of<SearchState>(context, listen: false);
  //  searchState.getDataFromDatabase();
  //}

  // void initNotification() {
  //   var state = Provider.of<NotificationState>(context, listen: false);
  //   var authState = Provider.of<AuthState>(context, listen: false);
  //   state.databaseInit(authState.userId);
  //   state.initFirebaseService();
  //   pushNotificationSubscription = getIt<PushNotificationService>()
  //       .pushNotificationResponseStream
  //       .listen(listenPushNotification);
  // }

  //void listenPushNotification(PushNotificationModel model) {
  //  final authState = Provider.of<AuthState>(context, listen: false);
  //  var state = Provider.of<NotificationState>(context, listen: false);
  //  if (model.type == NotificationType.Message.toString() &&
  //      model.receiverId == authState.user!.uid) {
  //    state.getUserDetail(model.senderId).then((user) {
  //      final chatState = Provider.of<ChatState>(context, listen: false);
  //      chatState.setChatUser = user!;
  //      Navigator.pushNamed(context, '/ChatScreenPage');
  //    });
  //  }
  //  else if (model.type == NotificationType.Mention.toString() &&
  //      model.receiverId == authState.user!.uid) {
  //    var feedState = Provider.of<FeedState>(context, listen: false);
  //    feedState.getPostDetailFromDatabase(model.postId);
  //    Navigator.push(context, FeedPostDetail.getRoute(model.postId));
  //  }
  //}

  void initChat() {
    //final chatState = Provider.of<ChatState>(context, listen: false);
    //final state = Provider.of<AuthState>(context, listen: false);
    //chatState.databaseInit(state.userId, state.userId);
    //state.updateFCMToken();
    //chatState.getFCMServerKey();
  }

  void initDynamicLinks() async {
    //FirebaseDynamicLinks.instance.onLink.listen(
    //  (PendingDynamicLinkData? dynamicLink) async {
    //    final Uri? deepLink = dynamicLink?.link;

    //    if (deepLink != null) {
    //      redirectFromDeepLink(deepLink);
    //    }
    //  },
    //  onError: (e) async {},
    //);

    //final PendingDynamicLinkData? data =
    //    await FirebaseDynamicLinks.instance.getInitialLink();
    //final Uri? deepLink = data?.link;

    //if (deepLink != null) {
    //  redirectFromDeepLink(deepLink);
    //}
  }

  void redirectFromDeepLink(Uri deepLink) {
    // cprint("Found Url from share: ${deepLink.path}");
    //var type = deepLink.path.split("/")[1];
    //var id = deepLink.path.split("/")[2];
    //if (type == "profilePage") {
    //  Navigator.push(context, ProfilePage.getRoute(profileId: id));
    //} else if (type == "tweet") {
    //  var feedState = Provider.of<FeedState>(context, listen: false);
    //  feedState.getPostDetailFromDatabase(id);
    //  Navigator.push(context, FeedPostDetail.getRoute(id));
    //}
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        child: _getPage(Provider.of<AppState>(context).pageIndex),
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return AllReadings();
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomMenubar(),
      body: _body(),
    );
  }
}
