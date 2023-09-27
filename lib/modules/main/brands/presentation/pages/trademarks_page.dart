import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_search_widget.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../../app/common/widgets/custom_intrinsic_grid_view.dart';
import '../controller/brands_bloc.dart';
import '../widgets/custom_trademark_item.dart';

class TrademarksPage extends StatefulWidget {
  const TrademarksPage({Key? key}) : super(key: key);

  @override
  State<TrademarksPage> createState() => _TrademarksPageState();
}

class _TrademarksPageState extends State<TrademarksPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  bool preventUpdatePage = false;
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  void getPageData({int start = 0}) {
    context.read<BrandsBloc>().add(
          GetBrandsEvent(
            parameter: DataLimitation(
              start: start,
              limit: 24,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<BrandsBloc, BrandsState>(
      listener: (context, state) {
        if (state.trademarkStatus == Status.loaded) {
          if (!preventUpdatePage) {
            setState(() {
              preventUpdatePage = true;
            });
          }
        }
      },
      builder: (context, state) => CustomPageHeader(
        show: state.trademarks.isNotEmpty,
        child: CustomRefreshWrapper(
          scrollController: scrollController,
          refreshData: getPageData,
          onListen: () => getPageData(start: state.trademarks.length),
          builder: (context, properties) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: CustomScrollView(
              controller:
                  state.trademarks.length <= 10 ? null : scrollController,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const CustomSearchWidget(),
                      Expanded(
                        child: state.trademarkStatus == Status.initial
                            ? const Center(child: LoadingIndicatorWidget())
                            : state.trademarkStatus == Status.error &&
                                    state.trademarks.isEmpty
                                ? Center(
                                    child: Lottie.asset(
                                      'assets/json/empty.json',
                                    ),
                                  )
                                : Column(
                                    children: [
                                      state.trademarkStatus == Status.loaded ||
                                              state.trademarkStatus ==
                                                  Status.loading
                                          ? Column(
                                              children: [
                                                SizedBox(height: 18.h),
                                                CustomText(
                                                  AppStrings.trademarks.tr(),
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                                SizedBox(height: 5.h),
                                                CustomText(
                                                  AppStrings.expoloreBrands
                                                      .tr(),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                SizedBox(height: 15.h),
                                              ],
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.zero),
                                      Expanded(
                                        child: CustomIntrinsicGridView(
                                          direction: Axis.vertical,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          horizontalSpace: 10.w,
                                          verticalSpace: 5.h,
                                          count: 3,
                                          children: List.generate(
                                            state.trademarks.length,
                                            (index) => CustomTradeMarkItem(
                                              width: 1.sw * 3.5,
                                              trademark:
                                                  state.trademarks[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: state.trademarkStatus ==
                                            Status.loading,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: ColorManager.primaryLight,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => preventUpdatePage;
}
