
import 'package:flutter/material.dart';
import 'package:ghealth_app/common/common.dart';
import 'package:ghealth_app/layers/model/vo_package.dart';
import 'package:ghealth_app/layers/presentation/widgets/frame_scaffold.dart';
import 'package:ghealth_app/layers/presentation/widgets/w_line.dart';
import '../../../../../common/data/validate/auth_validation_mixin.dart';
import '../../../../../common/util/local_json.dart';
import '../../../../model/authorization_test.dart';
import 'w_opensource_item.dart';

/// 아래의 명령어를 통해서, 주기적으로 라이센스 json을 최신화 해주세요.
/// flutter pub run flutter_oss_licenses:generate.dart -o assets/json/licenses.json --json
class OpensourceView extends StatefulWidget {
  const OpensourceView({super.key});

  @override
  State<OpensourceView> createState() => _OpensourceViewState();
}

class _OpensourceViewState extends State<OpensourceView> with AuthValidationMixin{
  List<Package> packageList = [];

  @override
  void initState() {
    checkAuthToken(context);
    initData();
    super.initState();
  }

  void initData() async {
    final list = await LocalJson.getObjectList<Package>("json/licenses.json");
    setState(() {
      packageList = list;
    });
  }

  String get title => '오픈소스 라이선스';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,

      body: ListView.separated(
        itemBuilder: (context, index) => OpensourceItem(packageList[index]),
        itemCount: packageList.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Line().pSymmetric(h:20);
        },
      ),
    );
  }
}
