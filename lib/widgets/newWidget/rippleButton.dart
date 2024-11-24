import 'package:flutter/material.dart';
import 'package:heartmonitor/ui/theme/theme.dart';

class RippleButton extends StatelessWidget {
  final Widget child;
  final Function? onPressed;
  final BorderRadius borderRadius;
  final Color? splashColor;
  const RippleButton({
    super.key,
    this.onPressed,
    this.splashColor,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: TextButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(borderRadius: borderRadius)),
              foregroundColor: WidgetStateProperty.all(AppColor.primary),
            ),
            onPressed: () {
              if (onPressed != null) {
                onPressed!();
              }
            },
            child: Container(),
          ),
        )
      ],
    );
  }
}
