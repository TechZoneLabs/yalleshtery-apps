import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../app/common/widgets/custom_text.dart';
import '../../../../../app/common/widgets/loading_indicator_widget.dart';
import '../../../../../app/helper/enums.dart';
import '../../../../../app/helper/navigation_helper.dart';
import '../../../../../app/utils/color_manager.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../controller/address_bloc.dart';

class AddressMapPage extends StatefulWidget {
  const AddressMapPage({Key? key}) : super(key: key);

  @override
  State<AddressMapPage> createState() => _AddressMapPageState();
}

class _AddressMapPageState extends State<AddressMapPage> {
  late AddressBloc addressBloc = context.read<AddressBloc>();
  late GoogleMapController mapController;
  @override
  void initState() {
    if (!addressBloc.hasDataSaved) {
      addressBloc.add(const GetCurrentPostionEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.background,
        centerTitle: true,
        leading: CloseButton(
          color: ColorManager.kBlack,
        ),
        title: CustomText(
          AppStrings.map.tr(),
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          color: ColorManager.kBlack,
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GestureDetector(
                onTap: () {
                  addressBloc.add(GetDataFromMap());
                  NavigationHelper.pop(context);
                },
                child: CustomText(
                  'Save'.tr(),
                  color: ColorManager.primaryLight,
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          LatLng initLatlng = state.latlng ??
              const LatLng(37.43296265331129, -122.08832357078792);
          return state.mapStatus == MapStatus.initializing
              ? const Center(
                  child: LoadingIndicatorWidget(),
                )
              : GoogleMap(
                  onTap: (val) =>
                      addressBloc.add(GetCurrentPostionEvent(latLng: val)),
                  onMapCreated: (controller) => mapController = controller,
                  initialCameraPosition: CameraPosition(
                    target: initLatlng,
                    zoom: 14.4746,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  markers: state.markers,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => addressBloc
            .add(RestLocationToCurrent(mapController: mapController)),
        child: const Icon(
          Icons.my_location,
          color: Colors.grey,
        ),
      ),
    );
  }
}
