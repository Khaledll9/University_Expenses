import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigatorBarNotifier extends Notifier<int> {
  @override
  int build() {
    return 1;
  }

  void setNavigationBar(int index) {
    state = index;
  }
}

final navigatorBarNotifierProvider =
    NotifierProvider<NavigatorBarNotifier, int>(() => NavigatorBarNotifier());
