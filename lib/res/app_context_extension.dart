
import 'package:flutter/cupertino.dart';
import 'package:ghealth_app/res/resources.dart';

/// The provided Dart code utilizes the extension feature to
/// add additional functionality to the BuildContext class in Flutter.
///
/// The AppContext extension is defined for the BuildContext class.
/// This extension adds new functionality to instances of the BuildContext class.
///
/// The Resources.of(this) is likely a method to find the Resources object
/// associated with the current BuildContext.
extension AppContext on BuildContext {
  Resources get resources => Resources.of(this);
}