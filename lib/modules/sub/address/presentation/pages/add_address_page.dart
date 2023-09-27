import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../app/common/widgets/custom_page_header.dart';
import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/helper_functions.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/routes_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../../../main/auth/presentation/widgets/custom_elevated_button.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/place.dart';
import '../controller/address_bloc.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  late AddressBloc addressBloc = context.read<AddressBloc>();
  ScrollController scrollController = ScrollController();
  Place? selectedCountry, selectedCity;
  DefaultStatus? defaultStatus = DefaultStatus.no;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController addressName = TextEditingController();
  TextEditingController buildingNo = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController landmark = TextEditingController();
  late List<Map<String, dynamic>> textList = [
    {
      'controller': addressName,
      'hintText': AppStrings.kAddressName,
    },
    {
      'controller': buildingNo,
      'hintText': AppStrings.buildingNo,
    },
    {
      'controller': streetName,
      'hintText': AppStrings.kStreetName,
    },
    {
      'controller': landmark,
      'hintText': AppStrings.landmark,
    },
  ];

  @override
  void initState() {
    getPlaces();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    addressBloc.add(CheckMapPermissionEvent());
    super.didChangeDependencies();
  }

  getPlaces({String id = '0'}) => addressBloc.add(GetPlacesEvent(id: id));
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () {
          if (addressBloc.hasDataSaved) {
            addressBloc.add(ClearSavedData());
          }
          return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: ColorManager.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorManager.background,
            centerTitle: true,
            leading: CloseButton(
              color: ColorManager.kBlack,
            ),
            title: CustomText(
              AppStrings.addAdress.tr(),
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: ColorManager.kBlack,
            ),
          ),
          body: BlocConsumer<AddressBloc, AddressState>(
            listener: (context, state) {
              if (state.coutriesStatus == Status.loaded) {
                if (state.coutries.length == 1) {
                  if (selectedCountry == null) {
                    selectedCountry = state.coutries[0];
                    getPlaces(id: selectedCountry!.id);
                  }
                }
              }
            },
            builder: (context, state) {
              if (state.mapStatus == MapStatus.dataSelected) {
                addressName.text = addressBloc.areaFromMap ?? '';
                streetName.text = addressBloc.streetFromMap ?? '';
              }
              return state.coutriesStatus == Status.loading
                  ? const Center(
                      child: LoadingIndicatorWidget(),
                    )
                  : CustomPageHeader(
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            children: [
                              Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    if (state.locationStatus ==
                                            LocationPermission.always ||
                                        state.locationStatus ==
                                            LocationPermission.whileInUse) {
                                      NavigationHelper.pushNamed(
                                        context,
                                        Routes.addressMapRoute,
                                      );
                                    } else {
                                      addressBloc
                                          .add(CheckMapPermissionEvent());
                                    }
                                  },
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  horizontalTitleGap: 0,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: ColorManager.border,
                                      width: 0.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  leading: const Icon(Icons.location_on),
                                  title: CustomText(
                                    'kChooseYourLoc'.tr(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<Place>(
                                  hint: CustomText(
                                    AppStrings.selectCountry.tr(),
                                    color: ColorManager.kBlack,
                                  ),
                                  buttonDecoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: ColorManager.border,
                                      width: 0.5,
                                    ),
                                  ),
                                  dropdownElevation: 5,
                                  dropdownMaxHeight: 0.5.sh,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.r),
                                      bottomRight: Radius.circular(8.r),
                                    ),
                                  ),
                                  icon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: SvgPicture.asset(
                                        'assets/icons/drop-down.svg'),
                                  ),
                                  iconSize: 26,
                                  isExpanded: true,
                                  scrollbarAlwaysShow: true,
                                  value: selectedCountry,
                                  items: state.coutries
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: CustomText(e.plaName),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        selectedCountry = value;
                                        selectedCity = null;
                                      });
                                      if (state.coutries.length > 1) {
                                        getPlaces(id: value.id);
                                      }
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 16.h),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<Place>(
                                  hint: CustomText(
                                    AppStrings.selectcity.tr(),
                                    color: ColorManager.kBlack,
                                  ),
                                  icon: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: SvgPicture.asset(
                                        'assets/icons/drop-down.svg'),
                                  ),
                                  scrollbarAlwaysShow: true,
                                  dropdownElevation: 5,
                                  buttonDecoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: ColorManager.border,
                                      width: 0.5,
                                    ),
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8.r),
                                      bottomRight: Radius.circular(8.r),
                                    ),
                                  ),
                                  dropdownMaxHeight: 0.5.sh,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  iconSize: 26,
                                  isExpanded: true,
                                  value: selectedCity,
                                  items: state.cities
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: CustomText(e.plaName),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCity = value;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    Column(
                                      children: List.generate(
                                        3,
                                        (index) {
                                          Map<String, dynamic> textinfo =
                                              textList[index];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 16.h),
                                            child: TextFormField(
                                              controller:
                                                  textinfo['controller'],
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                                  TextInputAction.next,
                                              style: TextStyle(fontSize: 20.sp),
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  // borderSide: const BorderSide(
                                                  //     color:
                                                  //         Colors.transparent),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                hintText: (textinfo['hintText']
                                                        as String)
                                                    .tr(),
                                                hintStyle: TextStyle(
                                                  fontSize: 18.sp,
                                                  color:
                                                      ColorManager.primaryLight,
                                                ),
                                              ),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? AppStrings.emptyVal.tr()
                                                      : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    TextFormField(
                                      controller: textList.last['controller'],
                                      maxLines: 4,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(fontSize: 20.sp),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          // borderSide: const BorderSide(
                                          //     color:
                                          //         Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        hintText: (textList.last['hintText']
                                                as String)
                                            .tr(),
                                        hintStyle: TextStyle(
                                          fontSize: 18.sp,
                                          color: ColorManager.primaryLight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(AppStrings.kdefault.tr()),
                                    Radio<DefaultStatus>(
                                      value: DefaultStatus.no,
                                      groupValue: defaultStatus,
                                      onChanged: (val) =>
                                          setState(() => defaultStatus = val),
                                      activeColor: ColorManager.primaryLight,
                                    ),
                                    CustomText('kNo'.tr()),
                                    Radio<DefaultStatus>(
                                      value: DefaultStatus.yes,
                                      groupValue: defaultStatus,
                                      onChanged: (val) =>
                                          setState(() => defaultStatus = val),
                                      activeColor: ColorManager.primaryLight,
                                    ),
                                    CustomText('kYes'.tr())
                                  ]),
                              SizedBox(height: 16.h),
                              CustomElevatedButton(
                                onPressed: () {
                                  if (!addressBloc.hasDataSaved) {
                                    HelperFunctions.showSnackBar(context,
                                        AppStrings.kChooseYourLoc.tr());
                                  } else if (selectedCountry == null) {
                                    HelperFunctions.showSnackBar(
                                        context, AppStrings.selectCountry.tr());
                                  } else if (selectedCity == null) {
                                    HelperFunctions.showSnackBar(
                                        context, AppStrings.selectcity.tr());
                                  } else if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    addressBloc.add(
                                      AddAddressEvent(
                                        address: Address(
                                          cityId: selectedCity!.id,
                                          countryId: selectedCountry!.id,
                                          title: addressName.text,
                                          buildingNumber: buildingNo.text,
                                          streetName: streetName.text,
                                          specialMarque: landmark.text,
                                          isDefault:
                                              defaultStatus == DefaultStatus.yes
                                                  ? '1'
                                                  : '0',
                                          cityName: selectedCity!.plaName,
                                          countryName: selectedCountry!.plaName,
                                          lat: state.latlng!.latitude,
                                          lon: state.latlng!.longitude,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                title: 'Save',
                                priColor: ColorManager.primaryLight,
                                titleColor: ColorManager.kWhite,
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      );
}
