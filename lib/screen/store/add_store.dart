import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';
import 'package:survey/screen/store/controller/add_store_controller.dart';
import '../../../utils/services/location_services.dart';

import '../../utils/appbar/main_appbar.dart';
import '../../utils/auth_button.dart';
import '../../utils/image_selection_row_button.dart';
import '../../utils/text_field.dart';
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
                      const SizedBox(height: 10,),
                      Text(
                        'Add Store Detail',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 23,
                          color: appMainColorDark,
                        ),
                      ),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const SizedBox(height: 25),
                        //const TitleText(title: "Store Name"),
                        const SizedBox(
                          height: 5,
                        ),
                        LabeledTextFormField(
                          hint: "Enter store name",
                          controller: controller.storeName.value,
                          requiredField: true,
                        ),
                        const SizedBox(height: 14),
                        // const TitleText(title: "Store City"),
                        const SizedBox(
                          height: 5,
                        ),
                        // LabeledTextFormField(
                        //   hint: "Enter store city",
                        //   controller: controller.city.value,
                        // ),
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
                        CityListDropDown(
                            initialValue: controller.selectedCity.value,
                            clientKey: controller.cityKey,
                            hintText: "Select City".tr,
                            clientData: controller.cityListData,
                            onChange: (value) {
                              controller.selectedCity.value = value;
                            }),
                        const SizedBox(height: 14),
                        //const TitleText(title: "Store District"),

                        LabeledTextFormField(
                          hint: "Enter store district",
                          controller: controller.district.value,
                          requiredField: true,
                        ),
                        const SizedBox(height: 14),
                        //const TitleText(title: "Store Area"),
                        const SizedBox(
                          height: 5,
                        ),
                        LabeledTextFormField(
                          hint: "Enter store area",
                          controller: controller.area.value,
                          requiredField: true,
                        ),
                        const SizedBox(height: 14),
                        //const TitleText(title: "Store Street"),
                        const SizedBox(
                          height: 5,
                        ),
                        LabeledTextFormField(
                          hint: "Enter store street",
                          controller: controller.street.value,
                          requiredField: true,
                        ),
                        const SizedBox(height: 14),
                        //const TitleText(title: "Approx. Store Space:"),
                        const SizedBox(
                          height: 5,
                        ),
                        LabeledTextFormField(
                          hint: "Enter store space",
                          controller: controller.approxSpace.value,
                          requiredField: true,
                        ),
                        const SizedBox(height: 14),
                        //const TitleText(title: "Nationality"),
                        const SizedBox(
                          height: 5,
                        ),
                        LabeledTextFormField(
                          hint: "Enter nationality",
                          controller: controller.nationality.value,
                          requiredField: true,
                        ),
                        const SizedBox(height: 14),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ImageRowButton(
                              isRequired: false,
                              imagePath: controller.imagePath.value,
                              onSelectImage: () {
                                controller.getImage();
                              }),
                        ),

                      ]),
                      AccountButton(
                        text: " Add ",
                        loading: controller.isLoading.value,
                        onTap: () {
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
