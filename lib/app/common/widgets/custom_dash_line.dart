import 'package:flutter/material.dart';

import '../../utils/color_manager.dart';

class DashedHorizontalLine extends StatelessWidget {
  const DashedHorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          for (int i = 0; i < 20; i++)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorManager.kGrey,
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
        ],
      );
}
