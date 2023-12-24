import 'package:task_manger/main.dart';
import 'package:task_manger/presentation_layer/utils/shard_function/printing_function_red.dart';

bool isSubScribe() {
  if (sharedPreferences.getBool('pay') == null ||
      sharedPreferences.getBool('pay') == false) {
    return false;
  }
  String dateValue = sharedPreferences.getString("timepay_at")!;

  DateTime parsedDate = DateTime.parse(dateValue);
  DateTime currentDate = DateTime.now();

  Duration difference = currentDate.difference(parsedDate);
  printRedColor(difference.inDays.toString());
  if (sharedPreferences.getString('type_pay') == "month") {
    printRedColor(difference.inDays.toString());
    if (difference.inDays > 30) {
      return false;
    }
  } else if (sharedPreferences.getString('type_pay') == "year") {
    printRedColor(difference.inDays.toString());
    if (difference.inDays > 365) {
      return false;
    }
  } else if (sharedPreferences.getString('type_pay') == "half-year") {
    printRedColor(difference.inDays.toString());
    if (difference.inDays > 180) {
      return false;
    }
  }

  return true;
}
