import 'package:flutter/material.dart';

import 'state_controller.dart';

class StateXWidget<T extends StateX, StateXType> extends StatelessWidget {
  const StateXWidget({
    super.key,
    required this.state,
    required this.builder,
    this.onClose,
    this.onError,
  });

  final T state;
  final Widget Function(StateXType) builder;
  final Widget Function(StateXType)? onClose;
  final Widget Function(StateXType)? onError;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: state.state,
      stream: state.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return onError?.call(snapshot.error as StateXType) ??
              const SizedBox.shrink();
        }
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return builder(snapshot.data as StateXType);
            case ConnectionState.done:
              return onClose?.call(snapshot.error as StateXType) ??
                  const SizedBox.shrink();
            default:
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
