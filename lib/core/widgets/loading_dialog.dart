import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class LoadingDialog {
  void show();
  Future<void> hide();
}

@Injectable()
class LoadingDialogImpl implements LoadingDialog {
  final OverlayEntry _entry;

  LoadingDialogImpl()
      : _entry = OverlayEntry(
          builder: (context) {
            return Container(
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            );
          },
        );

  @override
  Future<void> hide() async {
    _entry.remove();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  void show() {
    FocusManager.instance.primaryFocus?.unfocus();
    Asuka.addOverlay(_entry);
  }
}
