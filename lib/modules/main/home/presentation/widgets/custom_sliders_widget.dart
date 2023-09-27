import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/common/widgets/image_builder_widget.dart';
import '../../../../../app/common/widgets/loading_card.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/constants_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../sub/products/domain/usecases/get_product_details_use_case.dart';
import '../../../../sub/products/domain/usecases/get_products_by_parameter_use_case.dart';
import '../../../../sub/products/presentation/controller/products_bloc.dart';
import '../../domain/entities/slider_banner.dart';

class CustomSlidersWidget extends StatefulWidget {
  final Status status;
  final List<SliderBanner> data;
  final EdgeInsetsGeometry padding;
  const CustomSlidersWidget({
    Key? key,
    required this.data,
    required this.status,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  State<CustomSlidersWidget> createState() => _CustomSlidersWidgetState();
}

class _CustomSlidersWidgetState extends State<CustomSlidersWidget> {
  int currentPage = 0;
  void _launchURL(_url) async {
    await canLaunchUrl(Uri.parse(_url))
        ? await launchUrl(Uri.parse(_url))
        : throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    bool notLoading =
        widget.status == Status.loaded || widget.status == Status.error;
    return Padding(
      padding: notLoading && widget.data.isEmpty
          ? EdgeInsets.only(bottom: 15.h)
          : widget.padding,
      child: widget.status == Status.initial
          ? LoadingCard(
              height: 170.h,
              radius: 16.r,
            )
          : widget.data.isNotEmpty
              ? CarouselSlider(
                  items: List.generate(
                    widget.data.length,
                    (index) => Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            SliderBanner sliderBanner = widget.data[index];
                            if (sliderBanner.type == 'category') {
                              NavigationHelper.pushNamed(
                                context,
                                Routes.tempProductsRoute,
                                arguments: {
                                  'title': sliderBanner.title,
                                  'productsParmeters': ProductsParmeters(
                                    searchCategoryId: sliderBanner.url,
                                  ),
                                },
                              );
                            } else if (sliderBanner.type == 'innerLink') {
                              if (sliderBanner.urlType == 'product') {
                                context.read<ProductsBloc>().add(
                                      GetProductDetailsEvent(
                                        productDetailsParmeters:
                                            ProductDetailsParmeters(
                                          productId: sliderBanner.url,
                                        ),
                                      ),
                                    );
                                NavigationHelper.pushNamed(
                                  context,
                                  Routes.productDetailsRoute,
                                );
                              } else if (sliderBanner.urlType == 'trademark') {
                                NavigationHelper.pushNamed(
                                  context,
                                  Routes.tempProductsRoute,
                                  arguments: {
                                    'title': sliderBanner.title,
                                    'productsParmeters': ProductsParmeters(
                                      searchTrademarkId: sliderBanner.url,
                                    ),
                                  },
                                );
                              } else if (sliderBanner.urlType == 'service') {
                                NavigationHelper.pushNamed(
                                  context,
                                  Routes.tempProductsRoute,
                                  arguments: {
                                    'title': sliderBanner.title,
                                    'productsParmeters': ProductsParmeters(
                                      searchCategoryId: sliderBanner.url,
                                    ),
                                  },
                                );
                              }
                            } else if (widget.data[index].type == 'outerLink') {
                              String url = widget.data[index].url;
                              _launchURL(url);
                            }
                          },
                          child: ImageBuilder(
                            image:
                                '${AppConstants.imgUrl}/banners/${widget.data[index].image}',
                            width: 1.sw,
                            radius: 16.r,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Row(
                            children: List.generate(
                                widget.data.length,
                                (x) => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.only(right: 5),
                                      height: 3,
                                      width: 60.w,
                                      decoration: BoxDecoration(
                                        color: currentPage >= x
                                            ? ColorManager.primary
                                            : Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    )),
                          ),
                        )
                      ],
                    ),
                  ),
                  options: CarouselOptions(
                    height: 170.h,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (val, _) =>
                        setState(() => currentPage = val),
                    scrollDirection: Axis.horizontal,
                  ),
                )
              : const SizedBox(),
    );
  }
}
