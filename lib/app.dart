// import 'package:after_layout/after_layout.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:ghealth_app/common/cli_common.dart';
// import 'package:ghealth_app/common/common.dart';
//
// import 'package:flutter/material.dart';
// import 'package:ghealth_app/view/login/login_view.dart';
// import 'package:sizer/sizer.dart';
// import 'common/theme/custom_theme.dart';
// import 'common/theme/custom_theme_app.dart';
// import 'layers/model/authorization.dart';
//
// class App extends StatefulWidget {
//   static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
//
//   ///light, dark 테마가 준비되었고, 시스템 테마를 따라가게 하려면 해당 필드를 제거 하시면 됩니다.
//   static const defaultTheme = CustomTheme.light;
//   static bool isForeground = true;
//
//   const App({super.key});
//
//   @override
//   State<App> createState() => AppState();
// }
//
// class AppState extends State<App> with AfterLayoutMixin, WidgetsBindingObserver {
//
//   GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//       return CustomThemeApp(
//         child: Builder(
//           builder: (BuildContext context) {
//             return MaterialApp(
//               navigatorKey: App.navigatorKey,
//               debugShowCheckedModeBanner: false,
//               title: 'Onwards',
//               home: Sizer(
//                 builder: (context,  orientation, deviceType) {
//                   return const LoginView();
//                 },
//               ),
//               // initialBinding: TodoBindings(),
//             );
//           },
//         ),
//       );
//   }
//
//
//   @override
//   FutureOr<void> afterFirstLayout(BuildContext context) async {
//     /// 여기에 로그인, 로딩 준비 코드를 작성하면된다.
//     /// login(), loading(),
//     delay(() {
//       FlutterNativeSplash.remove();
//     }, 5000.ms);
//   }
// }
