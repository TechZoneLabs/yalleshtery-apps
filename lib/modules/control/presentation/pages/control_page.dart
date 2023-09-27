import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../../app/helper/shared_helper.dart';
import '../../../../app/services/services_locator.dart';
import '../../../../app/utils/constants_manager.dart';
import '../controller/control_bloc.dart';
import 'toggle_pages.dart';
import 'welcome_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  void initState() {
    context.read<ControlBloc>().add(GetContactInfoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    AppShared appShared = sl<AppShared>();
    bool authPass = appShared.getVal(AppConstants.authPassKey) ?? false;
    //bool welcomePass = appShared.getVal(AppConstants.welPassKey) ?? false;
    return authPass ? const TogglePages() : const WelcomePage();
  }
}
