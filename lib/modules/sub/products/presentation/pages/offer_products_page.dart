import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../main/home/domain/entities/offer.dart';
import '../../domain/usecases/get_products_by_parameter_use_case.dart';
import '../controller/products_bloc.dart';
import '../widgets/product_widget.dart';

class OfferProductsPage extends StatefulWidget {
  final ProductsParmeters productsParmeters;
  final OfferData offerData;
  const OfferProductsPage({
    Key? key,
    required this.productsParmeters,
    required this.offerData,
  }) : super(key: key);

  @override
  State<OfferProductsPage> createState() => _OfferProductsPageState();
}

class _OfferProductsPageState extends State<OfferProductsPage> {
  ScrollController scrollController = ScrollController();
  GlobalKey imgKey = GlobalKey();
  GlobalKey textKey = GlobalKey();
  bool waitUntil = true;
  double sliverAppBarheight = 0;
  late Timer timer;
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () => setState(
        () {
          double h = imgKey.currentContext!.size!.height +
              textKey.currentContext!.size!.height;
          sliverAppBarheight = h;
          waitUntil = false;
        },
      ),
    );
    getPageData();
    super.initState();
  }

  void getPageData({int start = 0}) => context.read<ProductsBloc>().add(
        GetCustomProductsEvent(
          productsParmeters: widget.productsParmeters.copyWith(
            start: start,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return state.customProdStatus == Status.initial || waitUntil
              ? Stack(
                  children: [
                    Opacity(
                      opacity: 0,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            key: imgKey,
                            child: ImageBuilder(
                              image:
                                  '${AppConstants.imgUrl.toString()}/offers/${widget.offerData.image}',
                              width: 1.sw,
                            ),
                          ),
                          Container(
                            key: textKey,
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            child: HtmlWidget(widget.offerData.description),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                      child: LoadingIndicatorWidget(),
                    ),
                  ],
                )
              : state.customProdStatus == Status.error &&
                      state.customProds.isEmpty
                  ? Column(
                      children: [
                        AppBar(
                          backgroundColor: ColorManager.background,
                          elevation: 0,
                          leading: CloseButton(color: ColorManager.kBlack,),
                        ),
                        Expanded(
                          child: Center(
                            child: Lottie.asset('assets/json/empty.json'),
                          ),
                        ),
                      ],
                    )
                  : CustomRefreshWrapper(
                      scrollController: scrollController,
                      refreshData: getPageData,
                      onListen: () =>
                          getPageData(start: state.customProds.length),
                      builder: (context, properties) => CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverAppBar(
                            floating: false,
                            snap: false,
                            pinned: false,
                            automaticallyImplyLeading: false,
                            backgroundColor: sliverAppBarheight == 0
                                ? ColorManager.background
                                : ColorManager.primaryLight,
                            expandedHeight: sliverAppBarheight,
                            bottom: const PreferredSize(
                              preferredSize: Size.fromHeight(60.0),
                              child: Text(''),
                            ),
                            excludeHeaderSemantics: true,
                            flexibleSpace: FlexibleSpaceBar(
                              background: sliverAppBarheight == 0
                                  ? const Padding(padding: EdgeInsets.zero)
                                  : SafeArea(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ImageBuilder(
                                                    image:
                                                        '${AppConstants.imgUrl.toString()}/offers/${widget.offerData.image}',
                                                    width: 1.sw,
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: HtmlWidget(
                                                    widget
                                                        .offerData.description,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color:
                                                    ColorManager.primaryLight,
                                              ),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                children: [
                                  state.customProds.length == 1
                                      ? Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: ProductWidget(
                                            product: state.customProds[0],
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10.h,
                                          ),
                                          child: Wrap(
                                            spacing: 10.w,
                                            runSpacing: 10.h,
                                            children: List.generate(
                                              state.customProds.length,
                                              (index) => SizedBox(
                                                width:
                                                    ScreenUtil().screenWidth /
                                                        2.25,
                                                child: ProductWidget(
                                                  product:
                                                      state.customProds[index],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  Visibility(
                                    visible: state.customProdStatus ==
                                        Status.loading,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: ColorManager.primaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
