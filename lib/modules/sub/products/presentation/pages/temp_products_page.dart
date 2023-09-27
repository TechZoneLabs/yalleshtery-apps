import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../control/presentation/widgets/temp_app_bar.dart';
import '../../domain/entities/filter.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';
import '../controller/products_bloc.dart';
import '../../../../../app/common/widgets/custom_intrinsic_grid_view.dart';
import '../widgets/product_widget.dart';
import '../widgets/sub_categories_tabs_widget.dart';

class TempProductsPage extends StatefulWidget {
  final String title;
  final ProductsParmeters productsParmeters;
  final bool fromFavoutites;
  const TempProductsPage({
    Key? key,
    required this.productsParmeters,
    required this.title,
    this.fromFavoutites = false,
  }) : super(key: key);

  @override
  State<TempProductsPage> createState() => _TempProductsPageState();
}

class _TempProductsPageState extends State<TempProductsPage> {
  ScrollController scrollController = ScrollController();
  bool scrolling = false;
  late ProductsParmeters productsParmeters = widget.productsParmeters;
  SortStatus? sortStatus;
  int choiceNumber = 0;
  late bool hasFilter = choiceNumber > 0;
  bool hasProductSort = false;
  @override
  void initState() {
    getPageData();
    if (!widget.fromFavoutites) {
      scrollController.addListener(() {
        if (scrollController.offset < 100) {
          setState(() {
            scrolling = false;
          });
        } else {
          setState(() {
            scrolling = true;
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void getPageData({int start = 0}) {
    context.read<ProductsBloc>().add(
          GetCustomProductsEvent(
            productsParmeters: productsParmeters.copyWith(start: start),
          ),
        );
    if (start == 0 && !widget.fromFavoutites && !hasFilter && !hasProductSort) {
      context.read<ProductsBloc>().add(
            GetFiltersEvent(
              productsParmeters: productsParmeters,
            ),
          );
    }
  }

  void sortProducts() async {
    SortStatus? tempStatus = await HelperFunctions.sortProducts(
      context: context,
      sortStatus: sortStatus,
    );
    if (tempStatus != null) {
      if (tempStatus != sortStatus) {
        scrolling = false;
        sortStatus = tempStatus;
        if (sortStatus == SortStatus.lh) {
          setState(() {
            hasProductSort = true;
            productsParmeters = productsParmeters.copyWith(
              sort: 'price',
              type: 'ASC',
            );
          });
        } else if (sortStatus == SortStatus.hl) {
          setState(() {
            hasProductSort = true;
            productsParmeters = productsParmeters.copyWith(
              sort: 'price',
              type: 'DESC',
            );
          });
        } else {
          setState(() {
            hasProductSort = true;
            productsParmeters = productsParmeters.copyWith(
              sort: 'id',
              type: 'DESC',
            );
          });
        }
        getPageData();
      }
    }
  }

  void filterProducts(Filter filters) => HelperFunctions.filterProducts(
        context: context,
        filters: filters,
        comeFromTrademark: widget.productsParmeters.searchTrademarkId != null,
        parmeters: productsParmeters,
        choiceNumber: choiceNumber,
        onApply: (parmeters, lastChoiceNumber) {
          NavigationHelper.pop(context);
          setState(() {
            choiceNumber = lastChoiceNumber;
            hasFilter = choiceNumber > 0;
            productsParmeters = parmeters;
          });
          getPageData();
        },
        onRest: () {
          NavigationHelper.pop(context);
          setState(() {
            choiceNumber = 0;
            hasFilter = false;
            productsParmeters = widget.productsParmeters;
            scrolling = false;
          });
          getPageData();
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) => Scaffold(
          backgroundColor: ColorManager.background,
          appBar: widget.fromFavoutites
              ? null
              : TempAppbar(
                  context: context,
                  pinned: true,
                  title: widget.title,
                  scrolling: scrolling && state.customProds.isNotEmpty,
                  forceShowTilte: state.customProds.isEmpty &&
                      state.customProdStatus == Status.error &&
                      !hasFilter,
                  sort: sortProducts,
                  sortColor: hasProductSort ? ColorManager.primaryLight : null,
                  filter: () => filterProducts(state.filters),
                  filterColor: hasFilter ? ColorManager.primaryLight : null,
                  searchCategoryId: widget.productsParmeters.searchCategoryId,
                  searchTrademarkId: widget.productsParmeters.searchTrademarkId,
                ),
          body: CustomRefreshWrapper(
            scrollController: scrollController,
            refreshData: getPageData,
            onListen: () => getPageData(start: state.customProds.length),
            builder: (context, properties) => CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: state.customProdStatus == Status.initial
                        ? const Center(child: LoadingIndicatorWidget())
                        : state.customProdStatus == Status.error &&
                                state.customProds.isEmpty &&
                                !hasFilter
                            ? Center(
                                child: Lottie.asset('assets/json/empty.json'))
                            : Column(
                                children: [
                                  widget.fromFavoutites
                                      ? const Padding(padding: EdgeInsets.zero)
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                widget.title,
                                                fontSize: 24.sp,
                                                fontWeight: FontWeight.w800,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                hasFilter &&
                                                        state
                                                            .customProds.isEmpty
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.zero)
                                                    : GestureDetector(
                                                        onTap: sortProducts,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    ColorManager
                                                                        .kGrey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.r),
                                                          ),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/sort.svg',
                                                            height: 20,
                                                            width: 12,
                                                            color: hasProductSort
                                                                ? ColorManager
                                                                    .primaryLight
                                                                : null,
                                                          ),
                                                        ),
                                                      ),
                                                SizedBox(width: 10.w),
                                                GestureDetector(
                                                  onTap: () => filterProducts(
                                                    state.filters,
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorManager
                                                              .kGrey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                    ),
                                                    child: SvgPicture.asset(
                                                      'assets/icons/filter.svg',
                                                      height: 20,
                                                      width: 12,
                                                      color: hasFilter
                                                          ? ColorManager
                                                              .primaryLight
                                                          : null,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  Expanded(
                                    child: hasFilter &&
                                            state.customProds.isEmpty
                                        ? Center(
                                            child: Lottie.asset(
                                              'assets/json/empty.json',
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              widget.productsParmeters
                                                              .searchCategoryId !=
                                                          null &&
                                                      !widget.fromFavoutites
                                                  ? SubCategoriesTabsWidget(
                                                      selectedsubCategoryId:
                                                          widget
                                                              .productsParmeters
                                                              .searchCategoryId!,
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 5.h),
                                                    ),
                                              state.customProds.length == 1
                                                  ? Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topStart,
                                                      child: ProductWidget(
                                                        fromFavoutites: widget
                                                            .fromFavoutites,
                                                        product: state
                                                            .customProds[0],
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child:
                                                          CustomIntrinsicGridView(
                                                        padding:
                                                            EdgeInsets.only(
                                                          bottom: 10.h,
                                                        ),
                                                        direction:
                                                            Axis.vertical,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        verticalSpace: 10,
                                                        horizontalSpace: 10,
                                                        children: List.generate(
                                                          state.customProds
                                                              .length,
                                                          (index) =>
                                                              ProductWidget(
                                                            fromFavoutites: widget
                                                                .fromFavoutites,
                                                            product: state
                                                                    .customProds[
                                                                index],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                              Visibility(
                                                visible:
                                                    state.customProdStatus ==
                                                        Status.loading,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 10.h,
                                                  ),
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: ColorManager
                                                        .primaryLight,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  )
                                ],
                              ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
