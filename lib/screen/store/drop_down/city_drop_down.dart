import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';

import '../model/city_list_model.dart';
class CityListDropDown extends StatelessWidget {
  const CityListDropDown({super.key,required this.initialValue,required this.clientKey,required this.hintText,required this.clientData,required this.onChange});

  final String hintText;
  final List<CityListModel> clientData;
  final CityListModel initialValue;
  final GlobalKey<FormFieldState> clientKey;
  final Function (CityListModel clientModel) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<CityListModel>(
      key: clientKey,
      value: initialValue.id == 0 ? null : initialValue ,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor:primaryColor,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
      items: clientData
          .map((item) => DropdownMenuItem<CityListModel>(
        value: item,
        enabled: item.id != -1,
        child: Text(
          item.name!,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
              fontWeight: FontWeight.w500
          )
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select driver name';
        }
        return null;
      },
      onChanged: (value) {
        onChange(value!);
      },
      onSaved: (value) {},
      buttonStyleData: const ButtonStyleData(
        height: 50,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData:const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: appMainColorDark,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
class RegionListDropDown extends StatelessWidget {
  const RegionListDropDown({super.key,required this.initialValue,required this.clientKey,required this.hintText,required this.clientData,required this.onChange});

  final String hintText;
  final List<CityListModel> clientData;
  final CityListModel initialValue;
  final GlobalKey<FormFieldState> clientKey;
  final Function (CityListModel clientModel) onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<CityListModel>(
      key: clientKey,
      value: initialValue.id == 0 ? null : initialValue ,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor:primaryColor,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
      items: clientData
          .map((item) => DropdownMenuItem<CityListModel>(
        value: item,
        enabled: item.id != -1,
        child: Text(
            item.name!,
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500
            )
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select driver name';
        }
        return null;
      },
      onChanged: (value) {
        onChange(value!);
      },
      onSaved: (value) {},
      buttonStyleData: const ButtonStyleData(
        height: 50,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData:const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: appMainColorDark,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}