import 'dart:developer';

import 'package:flutter/widgets.dart';

class DeviceTypeUtil {
  DeviceTypeUtil._();

  static bool isMobile(BuildContext context) {
    if ((MediaQuery.of(context).size.width < 600 &&
            MediaQuery.of(context).orientation == Orientation.portrait) ||
        (MediaQuery.of(context).size.width < 980 &&
            MediaQuery.of(context).orientation == Orientation.landscape)) {
      return true;
    }
    return false;
  }

  static bool isTablet(BuildContext context) {
    log('''
      Width: ${MediaQuery.of(context).size.width},
      Height: ${MediaQuery.of(context).size.height},

      ''', name: "MediaQuery");

    if ((MediaQuery.of(context).size.width > 600 &&
            MediaQuery.of(context).size.width < 900 &&
            MediaQuery.of(context).orientation == Orientation.portrait) ||
        (MediaQuery.of(context).size.width > 980 &&
            MediaQuery.of(context).size.width < 1200 &&
            MediaQuery.of(context).orientation == Orientation.landscape)) {
      return true;
    }
    return false;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 900;
  }
}
