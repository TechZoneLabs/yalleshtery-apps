import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_search_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../controller/home_bloc.dart';
import '../widgets/Custom_sliders_widget.dart';
import '../widgets/custom_offers_widget.dart';
import '../widgets/home_categories_widget.dart';
import '../widgets/home_products_widget.dart';
import '../widgets/home_trademarks_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  bool hasData = true, preventUpdatePage = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  void getPageData() {
    context.read<HomeBloc>().add(GetSliderBannersEvent());
    context.read<HomeBloc>().add(GetOffersEvent());
    context.read<HomeBloc>().add(const GetHomeCategoriesEvent());
    context.read<HomeBloc>().add(const GetTrademarksEvent());
    context.read<HomeBloc>().add(const GetLastestProductsEvent());
    context.read<HomeBloc>().add(const GetBestSellerProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.sliderBannerStatus == Status.loaded ||
            state.offerTypeStatus == Status.loaded ||
            state.categoryStatus == Status.loaded ||
            state.trademarkStatus == Status.loaded ||
            state.lastestProdStatus == Status.loaded ||
            state.bestSellerProdStatus == Status.loaded) {
          if (!preventUpdatePage) {
            setState(() {
              preventUpdatePage = true;
            });
          } else if (!hasData) {
            hasData = true;
          }
        } else if (state.sliderBannerStatus == Status.error &&
            state.offerTypeStatus == Status.error &&
            state.categoryStatus == Status.error &&
            state.trademarkStatus == Status.error &&
            state.lastestProdStatus == Status.error &&
            state.bestSellerProdStatus == Status.error) {
          hasData = false;
        }
      },
      builder: (ctx, state) {
        return CustomRefreshWrapper(
            scrollController: scrollController,
            refreshData: getPageData,
            builder: (context, properties) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            CustomPageHeader(
                              height: state.sliderBannersList.isNotEmpty
                                  ? 170.h
                                  : 0,
                              show: state.sliderBannerStatus == Status.loaded,
                              child: Column(
                                children: [
                                  const CustomSearchWidget(),
                                  hasData 
                                      ? CustomSlidersWidget(
                                          status: state.sliderBannerStatus,
                                          data: state.sliderBannersList,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16.h,
                                          ),
                                        )
                                      : const Padding(padding: EdgeInsets.zero)
                                ],
                              ),
                            ),
                            hasData
                                ? Column(
                                    children: [
                                      CustomOffersWidget(
                                        padding: EdgeInsets.only(bottom: 10.h),
                                        data: state.offerType.inSlider,
                                      ),
                                      HomeCategoriesWidget(
                                        status: state.categoryStatus,
                                        data: state.categories,
                                        padding: EdgeInsets.only(bottom: 5.h),
                                      ),
                                      CustomOffersWidget(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        data: state.offerType.inCategories,
                                      ),
                                      HomeTrademarksWidget(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        status: state.trademarkStatus,
                                        data: state.trademarks,
                                      ),
                                      CustomOffersWidget(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        data: state.offerType.inTrademarks,
                                      ),
                                      HomeProductsWidget(
                                        status: state.lastestProdStatus,
                                        title: 'New arrivals'.tr(),
                                        data: state.lastestProds,
                                        tempProductsType:
                                            TempProductsType.lastest,
                                        padding: EdgeInsets.only(bottom: 10.h),
                                      ),
                                      HomeProductsWidget(
                                        status: state.bestSellerProdStatus,
                                        title: 'Products on sale'.tr(),
                                        data: state.bestSellerProds,
                                        tempProductsType:
                                            TempProductsType.bestSeler,
                                        padding: EdgeInsets.only(bottom: 10.h),
                                      ),
                                    ],
                                  )
                                : Expanded(
                                    child: Center(
                                      child: Lottie.asset(
                                        'assets/json/empty.json',
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
      },
    );
  }

  @override
  bool get wantKeepAlive => preventUpdatePage;
}
