import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:webbing/data/pref.dart';

class River {
  static final internetConnectionCheckerProvider =
      StreamProvider.autoDispose<InternetConnectionStatus>(
          (ref) => InternetConnectionChecker().onStatusChange);

  static final remotePod = FutureProvider<String>((ref) async {
    late FirebaseRemoteConfig remoteConfig;
    final android = await DeviceInfoPlugin().androidInfo;
    if (!android.isPhysicalDevice) {
      return '';
    }
    try {
      await Firebase.initializeApp();
      remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 15),
      ));
      await remoteConfig.setDefaults(<String, dynamic>{
        'welcome': 'default welcome',
        'hello': 'default hello',
      });
    } catch (e) {
      throw Exception(e.toString());
    }
    final url = remoteConfig.getString('url');
    if (url != '') {
      Pref.setUrl = url;
      return url;
    }
    RemoteConfigValue(null, ValueSource.valueStatic);
    return Pref.getUrl;
  });
}
