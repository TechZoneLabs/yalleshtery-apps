import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../domain/usecases/rate_order_use_case.dart';
import '../controller/order_bloc.dart';

class RateOrderWidget extends StatelessWidget {
  final String unRatedOrderId;
  const RateOrderWidget({Key? key, required this.unRatedOrderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController rateNotes = TextEditingController();
    double rateVal = 0;
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) => CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 20.w,
              ),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Rate Order'.tr() + ' ',
                          style: TextStyle(
                            color: ColorManager.kBlack,
                            fontSize: 22.sp,
                          ),
                        ),
                        TextSpan(
                          text: '($unRatedOrderId)',
                          style: TextStyle(
                            color: ColorManager.primaryLight,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  Expanded(
                    child: state.rateOrderStatus == Status.loading
                        ? const LoadingIndicatorWidget()
                        : StatefulBuilder(
                            builder: (context, rateState) => Column(
                              children: [
                                RatingBar.builder(
                                  initialRating: rateVal,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 35,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: ColorManager.primaryLight,
                                  ),
                                  onRatingUpdate: (rating) {
                                    rateState(() {
                                      rateVal = rating;
                                    });
                                  },
                                ),
                                CustomText(
                                  'Tap a Star to Rate'.tr(),
                                ),
                                const Divider(),
                                Expanded(
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 4,
                                    controller: rateNotes,
                                    decoration: InputDecoration(
                                      hintText: 'Write your notes !'.tr(),
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomElevatedButton(
                                        onPressed: () => NavigationHelper.pop(
                                          context,
                                        ),
                                        title: 'Cancel',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: CustomElevatedButton(
                                        onPressed: rateVal == 0
                                            ? null
                                            : () => context
                                                .read<OrderBloc>()
                                                .add(
                                                  RateOrderEvent(
                                                    rateOrderParameters:
                                                        RateOrderParameters(
                                                      mode: 'invoice',
                                                      orderId: unRatedOrderId,
                                                      rateVal: rateVal,
                                                      rateNotes: rateNotes.text,
                                                    ),
                                                  ),
                                                ),
                                        title: 'Send',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
