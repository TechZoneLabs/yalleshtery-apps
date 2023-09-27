import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/helper/shared_helper.dart';
import '../../../../../app/services/services_locator.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../products/domain/usecases/get_product_details_use_case.dart';
import '../../../products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../products/presentation/controller/products_bloc.dart';
import '../../domain/usecases/add_search_product_report_use_case.dart';
import '../components/default_search_content.dart';
import '../components/search_data_content.dart';
import '../controller/search_bloc.dart';

class SearchPage extends StatefulWidget {
  final String? searchCategoryId, searchTrademarkId;
  const SearchPage({
    Key? key,
    this.searchCategoryId,
    this.searchTrademarkId,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool hasSearchVal = false;
  final AppShared appShared = sl<AppShared>();
  List<String> recentKeywords = [];
  @override
  void initState() {
    getRecentKeywords();
    super.initState();
  }

  getRecentKeywords() {
    List temp = appShared.getVal(AppConstants.recentKeywordsKey) ?? [];
    recentKeywords = temp.map((e) => e.toString()).toList();
  }

  onSearch({required String searchVal}) =>
      context.read<SearchBloc>().add(GetSearchData(searchVal: searchVal));

  toTempProducts({required String searchVal}) => NavigationHelper.pushNamed(
        context,
        Routes.tempProductsRoute,
        arguments: {
          'title': searchVal,
          'productsParmeters': ProductsParmeters(searchKey: searchVal),
        },
      );

  toProductDetails({required String prodId}) {
    context.read<ProductsBloc>().add(
          GetProductDetailsEvent(
            productDetailsParmeters: ProductDetailsParmeters(
              productId: prodId,
            ),
          ),
        );
    NavigationHelper.pushNamed(
      context,
      Routes.productDetailsRoute,
    );
  }

  handleRecent(String val) {
    int tempIndex = recentKeywords.indexWhere((element) => element == val);
    if (tempIndex > -1) {
      recentKeywords.removeAt(tempIndex);
    }
    recentKeywords.add(val);
    appShared.setVal(
      AppConstants.recentKeywordsKey,
      recentKeywords,
    );
    getRecentKeywords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
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
        title: CustomText(
          AppStrings.search.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: CustomPageHeader(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                onChanged: (value) {
                  if (value.length >= 3) {
                    setState(() => hasSearchVal = true);
                    onSearch(searchVal: value);
                  } else if (value.isEmpty) {
                    setState(() {
                      hasSearchVal = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Transform(
                        alignment: AlignmentDirectional.center,
                        transform: Matrix4.rotationY(
                          HelperFunctions.rotateVal(
                            context,
                            rotate: true,
                          ),
                        ),
                        child: SvgPicture.asset('assets/icons/search.svg')),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  hintText: AppStrings.searchHintText.tr(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.kBlack),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: BlocConsumer<SearchBloc, SearchState>(
                  listener: (context, state) {
                    if (state.searchStatus == Status.loaded &&
                        state.searchList.isNotEmpty) {
                      if (hasSearchVal) {
                        handleRecent(state.searchVal);
                        if (state.totalCount != -1) {
                          context.read<SearchBloc>().add(
                                AddSearchProductReportsEvent(
                                  searchReportsParameters:
                                      SearchReportsParameters(
                                    searchVal: state.searchVal,
                                    totalCount: state.totalCount.toString(),
                                    searchCategoryId: widget.searchCategoryId,
                                    searchTrademarkId: widget.searchTrademarkId,
                                  ),
                                ),
                              );
                        }
                      }
                    }
                  },
                  builder: (context, state) => !hasSearchVal
                      ? DefaultSearchContent(
                          recentData: recentKeywords,
                          toTempProducts: (String val) => toTempProducts(
                            searchVal: val,
                          ),
                          onClear: () {
                            sl<AppShared>().removeVal(
                              AppConstants.recentKeywordsKey,
                            );
                            setState(() => recentKeywords = []);
                          },
                        )
                      : state.searchStatus == Status.loaded &&
                              state.searchList.isNotEmpty
                          ? SearchDataContent(
                              data: state.searchList,
                              searchVal: state.searchVal,
                              toTempProducts: (val) => toTempProducts(
                                searchVal: val,
                              ),
                              toProductDetails: (val) => toProductDetails(
                                prodId: val,
                              ),
                            )
                          : state.searchStatus == Status.loading
                              ? Lottie.asset('assets/json/search.json')
                              : Lottie.asset('assets/json/empty.json'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
