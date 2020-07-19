import 'package:intl/intl.dart';
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
}
