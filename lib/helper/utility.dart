import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  Utility._internal();

  static String toDMYformate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  static String toformattedDate2(DateTime date) {
    return DateFormat('dd-MMM-yyyy hh:mm a').format(date);
  }

  static launchTo(String link) async {
    final isOK = await canLaunch(link);
    if (isOK) {
      launch(link);
    }
  }

  static share(String message){
    Share.share(message,);
  }
  static String getPassedTime(String date) {
    if (date == null || date.isEmpty) {
      return '';
    }
    String msg = '';
    var dt = DateTime.parse(date).toLocal();
  
    if (DateTime.now().toLocal().isBefore(dt)) {
      return DateFormat.jm().format(DateTime.parse(date).toLocal()).toString();
    }
  
    var dur = DateTime.now().toLocal().difference(dt);
    if (dur.inDays > 0) {
      msg = '${dur.inDays} d';
      // return dur.inDays == 1 ? '1d' : DateFormat("dd MMM").format(dt);
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
}
