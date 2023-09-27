import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/common/widgets/custom_radio_list.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../domain/entities/filter.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';

class CustomFilterWidget extends StatelessWidget {
  final Filter filters;
  final ProductsParmeters parmeters;
  final void Function(ProductsParmeters parmeters, int lastChoiceNumber)
      onApply;
  final void Function() onRest;

  final bool comeFromTrademark;
  final int choiceNumber;
  const CustomFilterWidget({
    Key? key,
    required this.filters,
    required this.parmeters,
    required this.onApply,
    required this.onRest,
    required this.comeFromTrademark,
    required this.choiceNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductsParmeters tempProductsPrameters = parmeters;
    List<Trade> trades = comeFromTrademark ? [] : filters.trades;
    bool showAll = false;
    RangeValues originalRange = RangeValues(
      filters.price.min.toDouble(),
      filters.price.max.toDouble(),
    );
    RangeValues priceSliderValues = RangeValues(
      tempProductsPrameters.minPrice != null
          ? double.parse(parmeters.minPrice!)
          : originalRange.start,
      tempProductsPrameters.maxPrice != null
          ? double.parse(parmeters.maxPrice!)
          : originalRange.end,
    );
    List<Map<String, dynamic>> availabilList = [
      {
        'title': 'Available',
        'filterType': 'in_stock',
      },
      {
        'title': 'Coming soon',
        'filterType': 'soon',
      },
      {
        'title': 'Offers',
        'filterType': 'offers',
      },
      {
        'title': 'Discount',
        'filterType': 'discounts',
      },
    ];
    int lastChoiceNumber = choiceNumber;

    return Container(
      constraints: BoxConstraints(maxHeight: 0.8.sh),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.h,
        ),
        child: StatefulBuilder(
          builder: (context, innerState) {
            List<Trade> tempTrades = showAll
                ? trades
                : trades.length > 5
                    ? trades.sublist(0, 5)
                    : trades;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: CustomText('Filter'.tr()),
                    ),
                    ButtonTheme(
                      padding: EdgeInsets.zero,
                      child: const CloseButton(),
                    ),
                  ],
                ),
                const Divider(),
                tempTrades.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        child: CustomText(
                          'Brands'.tr(),
                          color: ColorManager.kGrey,
                        ),
                      )
                    : const Padding(padding: EdgeInsets.zero),
                Column(
                  children: tempTrades.map(
                    (e) {
                      bool select =
                          tempProductsPrameters.searchTrademarkId == e.id;
                      return CustomRadioList(
                        title: e.value,
                        selected: select,
                        onTap: () {
                          innerState(
                            () {
                              tempProductsPrameters =
                                  tempProductsPrameters.copyWith(
                                searchTrademarkId: select ? '' : e.id,
                              );
                              if (select) {
                                lastChoiceNumber -= 1;
                              } else {
                                lastChoiceNumber += 1;
                              }
                            },
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
                Visibility(
                  visible: trades.length > 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: GestureDetector(
                      onTap: () => innerState(() => showAll = !showAll),
                      child: CustomText(
                        !showAll ? 'Show more'.tr() : 'Show less'.tr(),
                        color: ColorManager.primaryLight,
                      ),
                    ),
                  ),
                ),
                tempTrades.isEmpty
                    ? const Padding(padding: EdgeInsets.zero)
                    : const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  child: CustomText(
                    'Availability'.tr(),
                    color: ColorManager.kGrey,
                  ),
                ),
                Column(
                  children: List.generate(
                    availabilList.length,
                    (index) {
                      bool select = availabilList[index]['filterType'] ==
                          tempProductsPrameters.filterType;
                      return CustomRadioList(
                        title: (availabilList[index]['title'] as String).tr(),
                        selected: select,
                        onTap: () {
                          innerState(
                            () {
                              tempProductsPrameters =
                                  tempProductsPrameters.copyWith(
                                filterType: select
                                    ? ''
                                    : availabilList[index]['filterType'],
                              );
                              if (select) {
                                lastChoiceNumber -= 1;
                              } else {
                                lastChoiceNumber += 1;
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        'Price range'.tr(),
                        color: ColorManager.kGrey,
                      ),
                      CustomText(
                        '${filters.price.min} ' +
                            'EGP'.tr() +
                            ' - ' +
                            '${filters.price.max} ' +
                            'EGP'.tr(),
                      ),
                    ],
                  ),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    thumbColor: ColorManager.primaryLight,
                    activeTrackColor: ColorManager.primaryLight,
                  ),
                  child: RangeSlider(
                    values: priceSliderValues,
                    min: originalRange.start,
                    max: originalRange.end,
                    divisions: 15,
                    labels: RangeLabels(
                      priceSliderValues.start.toString(),
                      priceSliderValues.end.toString(),
                    ),
                    onChanged: (values) {},
                    onChangeEnd: (values) => innerState(
                      () {
                        priceSliderValues = RangeValues(
                          values.start.round().toDouble(),
                          values.end.round().toDouble(),
                        );
                        tempProductsPrameters = tempProductsPrameters.copyWith(
                          minPrice: priceSliderValues.start.toString(),
                          maxPrice: priceSliderValues.end.toString(),
                        );
                        if (priceSliderValues == originalRange) {
                          if (lastChoiceNumber > 0) {
                            lastChoiceNumber -= 1;
                          }
                        } else {
                          if (choiceNumber == 0) {
                            lastChoiceNumber = 1;
                          } else {
                            lastChoiceNumber += 1;
                          }
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        onPressed: lastChoiceNumber > 0
                            ? () {
                                if (choiceNumber > 0) {
                                  onRest();
                                } else {
                                  innerState(
                                    () {
                                      tempProductsPrameters = parmeters;
                                      priceSliderValues == originalRange;
                                      lastChoiceNumber=0;
                                    },
                                  );
                                }
                              }
                            : null,
                        title: 'clear',
                        titleColor: lastChoiceNumber > 0
                            ? ColorManager.kBlack.withOpacity(0.8)
                            : ColorManager.kWhite,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: CustomElevatedButton(
                        priColor: ColorManager.primaryLight,
                        titleColor: ColorManager.kWhite,
                        onPressed: (lastChoiceNumber > 0 || choiceNumber > 0) &&
                                lastChoiceNumber != choiceNumber
                            ? () => onApply(
                                  tempProductsPrameters,
                                  lastChoiceNumber,
                                )
                            : null,
                        title: 'Apply',
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
