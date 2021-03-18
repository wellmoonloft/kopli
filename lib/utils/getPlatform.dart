import 'dart:io';

class GetPlatform {
  bool isMobile = true;

  getIsMobile() {
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      isMobile = true;
    } else if (Platform.isAndroid || Platform.isIOS) {
      isMobile = false;
    }
    return isMobile;
  }
}
