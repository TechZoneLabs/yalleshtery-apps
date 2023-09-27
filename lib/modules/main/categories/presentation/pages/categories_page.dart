import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../app/common/model/data_limitation.dart';
import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_search_widget.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/common/widgets/custom_intrinsic_grid_view.dart';
import '../controller/categories_bloc.dart';
import '../widgets/custom_category_item.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  bool preventUpdatePage = false;
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  void getPageData({int start = 0}) {
    context.read<CategoriesBloc>().add(
          GetCategoriesEvent(
            parameter: DataLimitation(
              start: start,
              limit: 21,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        if (state.categoryStatus == Status.loaded) {
          if (!preventUpdatePage) {
            setState(() {
              preventUpdatePage = true; 
            });
          }
        }
      },
      builder: (context, state) => CustomPageHeader(
        show: state.categories.isNotEmpty,
        child: CustomRefreshWrapper(
          scrollController: scrollController,
          refreshData: getPageData,
          onListen: () => getPageData(start: state.categories.length),
          builder: (context, properties) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: CustomScrollView(
              controller:
                  state.categories.length <= 10 ? null : scrollController,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const CustomSearchWidget(),
                      Expanded(
                        child: state.categoryStatus == Status.initial
                            ? const Center(child: LoadingIndicatorWidget())
                            : state.categoryStatus == Status.error &&
                                    state.categories.isEmpty
                                ? Center(
                                    child:
                                        Lottie.asset('assets/json/empty.json'))
                                : Column(
                                    children: [
                                      CustomIntrinsicGridView(
                                        direction: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        horizontalSpace: 10.w,
                                        verticalSpace: 5.h,
                                        count: 3,
                                        children: List.generate(
                                          state.categories.length,
                                          (index) => CustomCategryItem(
                                            width: 1.sw / 3.5,
                                            category: state.categories[index],
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: state.categoryStatus ==
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
