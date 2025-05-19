import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';
import 'package:survey/screen/store/controller/add_store_controller.dart';
import '../../../utils/services/location_services.dart';

import '../../db_helper/db_constant.dart';
import '../../db_helper/db_helper.dart';
import '../../utils/appbar/main_appbar.dart';
import '../../utils/auth_button.dart';
import '../../utils/image_selection_row_button.dart';

import '../../utils/username_textfield.dart';
import '../../utils/utils.dart';
import 'drop_down/city_drop_down.dart';

class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({super.key});

  @override
  State<AddStoreScreen> createState() => _AddStoreScreen();
}

class _AddStoreScreen extends State<AddStoreScreen> {
  late AddStoreController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AddStoreController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
        Scaffold(
          backgroundColor: backgroundMain,
          appBar: const MainAppBar(
            title: "Add Store",
            subTitle: "apsco survey",
            isShowLogout: true,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(height: 15),
                        UserNameTextField(
                          controller: controller.storeName.value,
                          title: 'Store Name ',
                          hint: 'Enter store name',
                          isIconShow: false,
                        ),
                        const SizedBox(height: 14),
                        RegionListDropDown(
                            initialValue: controller.selectedRegion.value,
                            clientKey: controller.regionKey,
                            hintText: "Select Region".tr,
                            clientData: controller.regionListData,
                            onChange: (value) {
                              controller.selectedRegion.value = value;
                              controller.getCityListData(
                                  controller.selectedRegion.value.id);
                            }),
                        const SizedBox(height: 14),
                        controller.isCityLoading.value
                            ? const Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ):
                        RegionListDropDown(
                            initialValue: controller.selectedCity.value,
                            clientKey: controller.cityKey,
                            hintText: "Select City".tr,
                            clientData: controller.cityListData,
                            onChange: (value) {
                              controller.selectedCity.value = value;
                            }),
                        const SizedBox(height: 14),
                        UserNameTextField(
                          controller: controller.district.value,
                          title: 'District ',
                          hint: 'Enter store district',
                          isIconShow: false,
                        ),
                        const SizedBox(height: 14),
                        UserNameTextField(
                          controller: controller.area.value,
                          title: 'Area ',
                          hint: 'Enter store area',
                          isIconShow: false,
                        ),
                        const SizedBox(height: 14),
                        UserNameTextField(
                          controller: controller.street.value,
                          title: 'Street ',
                          hint: 'Enter store street',
                          isIconShow: false,
                        ),
                        const SizedBox(height: 14),
                        UserNameTextField(
                          controller: controller.approxSpace.value,
                          title: 'Space ',
                          hint: 'Enter store space',
                          isIconShow: false,
                        ),
                        const SizedBox(height: 14),
                        UserNameTextField(
                          controller: controller.nationality.value,
                          title: 'Nationality ',
                          hint: 'Enter nationality',
                          isIconShow: false,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: ImageRowButton(
                              isRequired: false,
                              imagePath: controller.imagePath.value,
                              onSelectImage: () {
                                controller.getImage();
                              }),
                        ),

                      ]),
                      AccountButton(
                        text: " Save ",
                        loading: controller.isLoading.value,
                        onTap: () {
                          DatabaseHelper.delete_table(DbConstant.sysTableEpscoQuestion);
                          DatabaseHelper.delete_table(DbConstant.transTableEpscoAnswer);
                          LocationService.getLocation().then((value) async => {
                            if (value["locationIsPicked"]) {
                              print("User Lat Long"),
                              controller.currentLocation.value=value['lat']+","+value['long'],
                              print(controller.currentLocation.value),
                              controller.saveApscoStore(context),
                            } else {
                              Utils.showSnackBar(value['msg'].toString(), SnackType.error),
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10,)
                    ],
                  ),
                ),
              )),
        )
    );
  }
}
