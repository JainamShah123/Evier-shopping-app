import 'package:flutter/material.dart';

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({
    Key? key,
    required this.primaryColor,
    required this.child,
  }) : super(key: key);

  final Color primaryColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: primaryColor),
    );
  }
}
