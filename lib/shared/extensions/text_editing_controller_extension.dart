import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension TextEditingControllerExtension on TextEditingController {
  void addHookListener(VoidCallback listener) {
    useEffect(() {
      addListener(listener);
      return () {
        removeListener(listener);
      };
    }, [this]);
  }
}
