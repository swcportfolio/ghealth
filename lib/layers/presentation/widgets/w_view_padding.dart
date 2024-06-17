import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/common/common.dart';

class ViewPadding extends StatelessWidget {
  final Widget child;

  const ViewPadding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.viewPadding,
      child: child,
    );
  }
}
