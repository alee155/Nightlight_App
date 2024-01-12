import 'package:package_info_plus/package_info_plus.dart';

class AppUtils {
  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
}
