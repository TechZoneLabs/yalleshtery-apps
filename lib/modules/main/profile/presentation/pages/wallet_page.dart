import 'package:flutter/material.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../widgets/wallet_totalamount_widget.dart';
import '../widgets/wallet_list_view.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.background,
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 25,
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.kBlack,
          ),
          onPressed: () => NavigationHelper.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: const [WalletTotalAmount(), WalletWidget()],
      ),
    );
  }
}
