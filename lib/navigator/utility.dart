import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/newWidget/customLoader.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference userDatabase = FirebaseDatabase.instance.ref();
final appScreenLoader = CustomLoader();
void cprint(dynamic data,
    {String? errorIn, String? event, String label = 'Log'}) {
  if (kDebugMode) {
    if (errorIn != null) {
      developer.log('[Error]',
          time: DateTime.now(), error: data, name: errorIn);
    } else if (data != null) {
      developer.log(data, time: DateTime.now(), name: label);
    }
    if (event != null) {
      Utility.logEvent(event, parameter: {});
    }
  }
}

class Utility {
  static String getPostTime2(String? date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat =
        '${DateFormat.jm().format(dt)} - ${DateFormat("dd MMM yy").format(dt)}';
    return dat;
  }

  static String getCommentTime(String? date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat = DateFormat("dd MMM yy").format(dt);
    return dat;
  }

  static String getDob(String? date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat = DateFormat.yMMMd().format(dt);
    return dat;
  }

  static String getJoiningDate(String? date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    var dt = DateTime.parse(date).toLocal();
    var dat = DateFormat("MMMM yyyy").format(dt);
    return 'Joined $dat';
  }

  static String getChatTime(String? date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    String msg = '';
    var dt = DateTime.parse(date).toLocal();
    if (DateTime.now().toLocal().isBefore(dt)) {
      return DateFormat.jm().format(DateTime.parse(date).toLocal()).toString();
    }
    var dur = DateTime.now().toLocal().difference(dt);
    if (dur.inDays > 365) {
      msg = DateFormat.yMMMd().format(dt);
    } else if (dur.inDays > 30) {
      msg = DateFormat.yMMMd().format(dt);
    } else if (dur.inDays > 0) {
      msg = '${dur.inDays} d';
      return dur.inDays == 1 ? '1d' : DateFormat.MMMd().format(dt);
    } else if (dur.inHours > 0) {
      msg = '${dur.inHours} h';
    } else if (dur.inMinutes > 0) {
      msg = '${dur.inMinutes} m';
    } else if (dur.inSeconds > 0) {
      msg = '${dur.inSeconds} s';
    } else {
      msg = 'now';
    }
    return msg;
  }

  static String getPollTime(String date) {
    int hr, mm;
    String msg = 'Poll ended';
    var endDate = DateTime.parse(date);
    if (DateTime.now().isAfter(endDate)) {
      return msg;
    }
    msg = 'Poll ended in';
    var dur = endDate.difference(DateTime.now());
    hr = dur.inHours - dur.inDays * 24;
    mm = dur.inMinutes - (dur.inHours * 60);
    if (dur.inDays > 0) {
      msg = ' ${dur.inDays}${dur.inDays > 1 ? ' Days ' : ' Day'}';
    }
    if (hr > 0) {
      msg += ' $hr hour';
    }
    if (mm > 0) {
      msg += ' $mm min';
    }
    return '${dur.inDays} Days  $hr Hours $mm min';
  }

  static String? getSocialLinks(String? url) {
    if (url != null && url.isNotEmpty) {
      url = url.contains("https://www") || url.contains("http://www")
          ? url
          : url.contains("www") &&
                  (!url.contains('https') && !url.contains('http'))
              ? 'https://$url'
              : 'https://www.$url';
    } else {
      return null;
    }
    return url;
  }

  static launchURL(String url) async {
    if (url == "") {
      return;
    }
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchURL(url);
    } else {}
  }

  static void logEvent(String event, {Map<String, dynamic>? parameter}) {
    //userAnalytics.logEvent(name: event, parameters: parameter);
  }

  static void share(String message, {String? subject}) {
    Share.share(message, subject: subject);
  }

  static List<String> getHashTags(String text) {
    RegExp reg = RegExp(
        r"([#])\w+|(https?|ftp|file|#)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]+[-A-Za-z0-9+&@#/%=~_|]*");
    Iterable<Match> matches = reg.allMatches(text);
    List<String> resultMatches = <String>[];
    for (Match match in matches) {
      if (match.group(0)!.isNotEmpty) {
        var tag = match.group(0);
        resultMatches.add(tag!);
      }
    }
    return resultMatches;
  }

  static String getUserName({
    required String id,
    required String name,
  }) {
    String userName = '';
    if (name.length > 15) {
      name = name.substring(0, 6);
    }
    name = name.split(' ')[0];
    id = id.substring(0, 4).toLowerCase();
    userName = '@$name$id';
    return userName;
  }

  static bool validateCredentials(
      BuildContext context, String? email, String? password) {
    if (email == null || email.isEmpty) {
      customSnackBar(context, 'Please enter email id');
      return false;
    } else if (password == null || password.isEmpty) {
      customSnackBar(context, 'Please enter password');
      return false;
    } else if (password.length < 8) {
      customSnackBar(context, 'Password must be 8 character long');
      return false;
    }

    var status = validateEmail(email);
    if (!status) {
      customSnackBar(context, 'Please enter valid email id');
      return false;
    }
    return true;
  }

  static customSnackBar(BuildContext context, String msg,
      {double height = 30}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool validateEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    var status = regExp.hasMatch(email);
    return status;
  }

  //static Future<Uri> createLinkToShare(BuildContext context, String id,
  //    {required SocialMetaTagParameters socialMetaTagParameters}) async {
  //  final DynamicLinkParameters parameters = DynamicLinkParameters(
  //    uriPrefix: 'https://heartmonitor.page.link',
  //    link: Uri.parse(''),
  //    androidParameters: const AndroidParameters(
  //      packageName: 'com.heartmonitor',
  //      minimumVersion: 0,
  //    ),
  //    socialMetaTagParameters: socialMetaTagParameters,
  //  );
  //  Uri url;
  //  final ShortDynamicLink shortLink =
  //      await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  //  url = shortLink.shortUrl;
  //  return url;
  //}

  //static createLinkAndShare(BuildContext context, String id,
  //    {required SocialMetaTagParameters socialMetaTagParameters}) async {
  //  var url = await createLinkToShare(context, id,
  //      socialMetaTagParameters: socialMetaTagParameters);
  //  share(url.toString(), subject: "Post");
  //}

  static shareFile(List<String> path, {String text = ""}) {
    try {
      Share.shareFiles(path, text: text);
    } catch (error) {
      SnackBar(content: Text(error.toString()));
    }
  }

  static void copyToClipBoard(
      {required BuildContext context,
      required String text,
      required String message}) {
    var data = ClipboardData(text: text);
    Clipboard.setData(data);
    customSnackBar(context, message);
  }

  static Locale getLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }
}
