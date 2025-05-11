// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:survey/res/app_color.dart';
//
// import '../../../utils/img_list_button/img_list_button.dart';
// import '../../../utils/text_field.dart';
// import '../model/sys_survey_question_option_model.dart';
//
// class SurveyQuestionCard extends StatelessWidget {
//   final String question;
//   final int number;
//   final List<sysSurveyQuestionOptionModel> answers1;
//   final List<File> imagesList;
//   final bool isImageLoading;
//   final Function getImage;
//   final String answerType;
//   final String onYesGetValue;
//   final String onYesGetImage;
//   final dynamic selectedAnswerRadio;
//   final ValueChanged<String>? onRadioSelect;
//   final TextEditingController valueControllerComment;
//
//   const SurveyQuestionCard({
//     super.key,
//     required this.question,
//     required this.answers1,
//     required this.answerType,
//     required this.selectedAnswerRadio,
//     this.onRadioSelect,
//     required this.number,
//     required this.isImageLoading,
//     required this.getImage,
//     required this.onYesGetValue,
//     required this.onYesGetImage,
//     required this.imagesList,
//     required this.valueControllerComment,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade200),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 "${number.toString()}) ",
//                 style: GoogleFonts.poppins(
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold,
//                     color: appMainColorDark
//                 )
//               ),
//               const SizedBox(width: 7,),
//               Expanded(
//                 child: Text(
//                   question,
//                   style: GoogleFonts.poppins(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: appMainColorDark,
//                   )
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           if (answerType == "radio")
//             Column(
//               children: answers1.map((answer) {
//                 return StylishRadioTile(
//                   value: answer.en_name.toString(),
//                   groupValue: selectedAnswerRadio,
//                   onSelected: onRadioSelect!,
//                 );
//               }).toList(),
//             ),
//           if(answerType == "radio")
//             const SizedBox(height: 5,),
//
//           if(answerType == "number" && onYesGetImage == "N")
//             TextField(
//               showCursor: true,
//               enableInteractiveSelection: false,
//               onChanged: (value) {
//                 print(value);
//               },
//               controller: valueControllerComment,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                   prefixIconColor: appMainColorDark,
//                   focusColor: appMainColorDark,
//                   fillColor: appMainColorDark,
//                   labelStyle:
//                   TextStyle(color: appMainColorDark, height: 50.0),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 1, color:appMainColorDark)),
//                   border: OutlineInputBorder(),
//                   hintText: 'Please Enter count'),
//
//             ),
//           if(answerType == "text")
//             TextField(
//               showCursor: true,
//               enableInteractiveSelection: false,
//               onChanged: (value) {
//                 print(value);
//               },
//               controller: valueControllerComment,
//               keyboardType: TextInputType.text,
//               decoration: const InputDecoration(
//                   prefixIconColor: appMainColorDark,
//                   focusColor: appMainColorDark,
//                   fillColor: appMainColorDark,
//                   labelStyle:
//                   TextStyle(color: appMainColorDark, height: 50.0),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 1, color: appMainColorDark)),
//                   border: OutlineInputBorder(),
//                   hintText: 'Please Enter your comment'),
//
//             ),
//           if(selectedAnswerRadio == "Yes" && onYesGetValue == "number")
//             TextField(
//               showCursor: true,
//               enableInteractiveSelection: false,
//               onChanged: (value) {
//                 print(value);
//               },
//               controller: valueControllerComment,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                   prefixIconColor: appMainColorDark,
//                   focusColor: appMainColorDark,
//                   fillColor: appMainColorDark,
//                   labelStyle:
//                   TextStyle(color: appMainColorDark, height: 50.0),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 1, color: appMainColorDark)),
//                   border: OutlineInputBorder(),
//                   hintText: 'Please enter count'),
//
//             ),
//           if(selectedAnswerRadio == "Yes" && onYesGetValue == "text")
//             TextField(
//               showCursor: true,
//               enableInteractiveSelection: false,
//               onChanged: (value) {
//                 print(value);
//               },
//               controller: valueControllerComment,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                   prefixIconColor: appMainColorDark,
//                   focusColor: appMainColorDark,
//                   fillColor: appMainColorDark,
//                   labelStyle:
//                   TextStyle(color: appMainColorDark, height: 50.0),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 1, color: appMainColorDark)),
//                   border: OutlineInputBorder(),
//                   hintText: 'Please Enter your comment'),
//
//             ),
//           if(selectedAnswerRadio == "Yes" && onYesGetImage == "Y")
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               height: 150,
//               width: double.infinity,
//               child: isImageLoading
//                   ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//                   : ImageListButtonForSurvey(
//                 imageFile: imagesList,
//                 onSelectImage: () {
//                   getImage();
//                 },
//               ),
//             ),
//           if(answerType == "image")
//             Container(
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               height: 150,
//               width: double.infinity,
//               child: isImageLoading
//                   ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//                   : ImageListButtonForSurvey(
//                 imageFile: imagesList,
//                 onSelectImage: () {
//                   getImage();
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class StylishRadioTile extends StatelessWidget {
//   final String value;
//   final String? groupValue;
//   final ValueChanged<String> onSelected;
//
//   const StylishRadioTile({
//     super.key,
//     required this.value,
//     required this.groupValue,
//     required this.onSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = value == groupValue;
//     return GestureDetector(
//       onTap: () => onSelected(value),
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 6),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? appMainColorDark.withOpacity(0.08) : Colors.grey.shade50,
//           border: Border.all(
//             color: isSelected ? appMainColorDark : Colors.grey.shade300,
//             width: 2,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 25,
//               height: 25,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected ? appMainColorDark : Colors.grey,
//                   width: 2.3,
//                 ),
//               ),
//               child: isSelected
//                   ? Center(
//                 child: Container(
//                   width: 11,
//                   height: 11,
//                   decoration: const BoxDecoration(
//                     color: appMainColorLight,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               )
//                   : const SizedBox.shrink(),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 value,
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                   color: isSelected ? appMainColorDark : Colors.black87,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//











import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey/res/app_color.dart';
import 'package:survey/utils/title_text.dart';
import '../../../utils/img_list_button/img_list_button.dart';
import '../../../utils/text_field.dart';
import '../model/sys_survey_question_option_model.dart';

class SurveyQuestionCard extends StatelessWidget {
  const SurveyQuestionCard({
    super.key,
    required this.question,
    required this.answers1,
    required this.answerType,
    required this.selectedAnswerRadio,
    this.onRadioSelect,
    required this.number,
    required this.isImageLoading,
    required this.getImage,
    required this.onYesGetValue,
    required this.onYesGetImage,
    required this.imagesList,
    required this.skuImage,
    required this.valueControllerComment,
  });

  final String question;
  final int number;
  final List<sysSurveyQuestionOptionModel> answers1;
  final List<File> imagesList;
  final bool isImageLoading;
  final Function getImage;
  final String answerType;
  final String onYesGetValue;
  final String onYesGetImage;
  final String skuImage;
  final dynamic selectedAnswerRadio;
  final ValueChanged<String>? onRadioSelect;
  final TextEditingController valueControllerComment;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.network(
                  skuImage,
                  width: 180,
                  height: 130,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${number.toString()}) ",
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: appMainColorDark
                        ),
                      ),
                      const SizedBox(width: 7,),
                      Expanded(
                        child: Text(
                          question,
                          style:GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: appMainColorDark
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (answerType == "radio")
                    Column(
                      children: answers1.map((answer) {
                        return StylishRadioTile(
                          value: answer.en_name.toString(),
                          groupValue: selectedAnswerRadio,
                          onSelected: onRadioSelect!,
                        );
                      }).toList(),
                    ),
                  if(answerType == "radio")
                    const SizedBox(height: 5,),
                  if(answerType == "number")
                    TextField(
                      showCursor: true,
                      enableInteractiveSelection: false,
                      onChanged: (value) {
                        print(value);
                      },
                      controller: valueControllerComment,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        prefixIconColor: appMainColorDark,
                        focusColor: appMainColorDark,
                        fillColor: appMainColorDark,
                        labelStyle:  const TextStyle(color: appMainColorDark, height: 1.5),
                        focusedBorder:  const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: appMainColorDark),
                        ),
                        border: const OutlineInputBorder(),
                        label: RichText(
                          text: const TextSpan(
                            text: 'Value ',
                            style: TextStyle(color: appMainColorDark, fontSize: 16.0),
                            children: [
                              TextSpan(
                                text: '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  if(answerType == "text")
                    CommentTextFormField(
                      hint: "Enter your comment",
                      controller: valueControllerComment,
                    ),
                  if(selectedAnswerRadio == "Yes" && onYesGetValue == "number")
                    TextField(
                      showCursor: true,
                      enableInteractiveSelection: false,
                      onChanged: (value) {
                        print(value);
                      },
                      controller: valueControllerComment,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          prefixIconColor: appMainColorDark,
                          focusColor: appMainColorDark,
                          fillColor: appMainColorDark,
                          labelStyle:
                          TextStyle(color: appMainColorDark, height: 50.0),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: appMainColorDark)),
                          border: OutlineInputBorder(),
                          hintText: 'Please enter count'),

                    ),
                  if(selectedAnswerRadio == "Yes" && onYesGetValue == "text")
                    CommentTextFormField(
                      hint: "Enter your comment",
                      controller: valueControllerComment,
                    ),
                  if(selectedAnswerRadio == "Yes" && onYesGetImage == "Y")
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 180,
                      width: double.infinity,
                      child: isImageLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ImageListButtonForSurvey(
                        imageFile: imagesList,
                        onSelectImage: () {
                          getImage();
                        }, isRequried: true,
                      ),
                    ),
                  if(answerType == "number" && onYesGetImage == "Y")
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 180,
                      width: double.infinity,
                      child: isImageLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ImageListButtonForSurvey(
                        imageFile: imagesList,
                        onSelectImage: () {
                          getImage();
                        }, isRequried: false,
                      ),
                    ),
                  if(answerType == "text" && onYesGetImage == "Y")
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 180,
                      width: double.infinity,
                      child: isImageLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ImageListButtonForSurvey(
                        imageFile: imagesList,
                        onSelectImage: () {
                          getImage();
                        }, isRequried: false,
                      ),
                    ),
                  if(answerType == "image")
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 180,
                      width: double.infinity,
                      child: isImageLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : ImageListButtonForSurvey(
                        imageFile: imagesList,
                        onSelectImage: () {
                          getImage();
                        }, isRequried: true,
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class StylishRadioTile extends StatelessWidget {
  final String value;
  final String? groupValue;
  final ValueChanged<String> onSelected;

  const StylishRadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onSelected(value),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? appMainColorDark.withOpacity(0.08) : Colors.grey.shade50,
          border: Border.all(
            color: isSelected ? appMainColorDark : Colors.grey.shade300,
            width: 1.9,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? appMainColorDark : Colors.grey,
                  width: 2.3,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 11,
                  height: 11,
                  decoration: const BoxDecoration(
                    color: appMainColorLight,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? appMainColorDark : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}