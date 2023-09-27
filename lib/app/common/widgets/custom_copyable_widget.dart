import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/color_manager.dart';
import '../../utils/strings_manager.dart';
import 'custom_text.dart';

class CustomCopyableWidget extends StatelessWidget {
  final Widget widget;
  final String copyText;
  const CustomCopyableWidget(
      {Key? key, required this.widget, required this.copyText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool blurDescription = false;
    late Offset descriptionPosition;
    return StatefulBuilder(
      builder: (context, descriptionState) => GestureDetector(
        onLongPress: () async {
          descriptionState(
            () => blurDescription = true,
          );
          final RenderBox overlay =
              Overlay.of(context)!.context.findRenderObject() as RenderBox;
          int? delta = await showMenu(
            context: context,
            items: [
              PopupMenuItem<int>(
                value: 0,
                child: Center(
                  child: CustomText(
                    AppStrings.copy.tr(),
                  ),
                ),
              ),
            ],
            position: RelativeRect.fromRect(
              descriptionPosition &
                  const Size(
                    40,
                    40,
                  ),
              Offset.zero & overlay.size,
            ),
          );
          if (delta != null) {
            await Clipboard.setData(
              ClipboardData(
                text: copyText,
              ),
            );
          }
          descriptionState(
            () => blurDescription = false,
          );
        },
        onTapDown: (details) => descriptionState(
          () => descriptionPosition = details.globalPosition,
        ),
        child: Container(
          color: blurDescription ? ColorManager.kBlack.withOpacity(0.5) : null,
          child: widget,
        ),
      ),
    );
  }
}
