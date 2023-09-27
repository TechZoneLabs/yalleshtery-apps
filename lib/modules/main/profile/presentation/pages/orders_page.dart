import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_refresh_wrapper.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../sub/order/domain/entities/order.dart';
import '../../../../sub/order/presentation/controller/order_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late OrderBloc orderBloc = context.read<OrderBloc>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    getPageData();
    super.initState();
  }

  getPageData({int start = 0}) => orderBloc.add(GetOrdersEvent(start: start));

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
          AppStrings.myOrders.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) => state.getOrdersStatus == Status.initial
            ? const Center(
                child: LoadingIndicatorWidget(),
              )
            : state.getOrdersStatus == Status.error && state.orders.isEmpty
                ? Center(
                    child: Lottie.asset('assets/json/empty.json'),
                  )
                : CustomPageHeader(
                    child: CustomRefreshWrapper(
                      scrollController: scrollController,
                      refreshData: getPageData,
                      onListen: () => getPageData(
                        start: state.orders.length,
                      ),
                      builder: (context, properties) => Column(
                        children: [
                          Expanded(
                            child: Theme(
                              data: ThemeData(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                              ),
                              child: ListView.separated(
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 0, 15.w, 10.h),
                                controller: scrollController,
                                itemCount: state.orders.length,
                                itemBuilder: (context, index) {
                                  OrderEntity order = state.orders[index];
                                  bool cancel = order.status == 'canceled';
                                  return ListTile(
                                    onTap: () {
                                      orderBloc.add(
                                          GetOrderDetailsEvent(id: order.id));
                                      NavigationHelper.pushNamed(
                                        context,
                                        Routes.ordersDetailsRoute,
                                      );
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    title: CustomText(
                                      DateFormat(
                                        'yyyy:MM:dd | hh:mm a',
                                        'en',
                                      ).format(
                                        DateTime.parse(
                                          order.dateAdded,
                                        ),
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        SizedBox(height: 4.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              'order ID'.tr() +
                                                  ' : ' +
                                                  order.id,
                                            ),
                                            CustomText(
                                              'Total'.tr() +
                                                  ' : ' +
                                                  order.totalPrice +
                                                  ' ' +
                                                  AppStrings.egp.tr(),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: ColorManager.kBlack,
                                              size: 20,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            CustomText(
                                                'Order status'.tr() + ' : '),
                                            CustomText(
                                              order.status.tr(),
                                              color: cancel
                                                  ? ColorManager.kRed
                                                  : ColorManager.primaryLight,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: state.getOrdersStatus == Status.loading,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
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
                  ),
      ),
    );
  }
}
