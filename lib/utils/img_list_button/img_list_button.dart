// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:survey/utils/title_text.dart';
//
// class ImageListButtonForSurvey extends StatelessWidget {
//   const ImageListButtonForSurvey({super.key,required this.imageFile,required this.onSelectImage, required this.isRequried});
//   final List<File> imageFile;
//   final Function onSelectImage;
//   final bool isRequried;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         isRequried? const Row(
//           children: [
//             TitleText(title: " Take Image ", color: Colors.black,),
//             TitleText(title: "*", color: Colors.redAccent,)
//           ],
//         ):const SizedBox(height: 8,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width/3,
//               height: MediaQuery.of(context).size.height/6,
//               child: InkWell(
//                 onTap: () {
//                   onSelectImage();
//                 },
//                 child: Card(
//                   color: Colors.grey.shade200,
//                   elevation: .25,
//                   child:const Icon(Icons.camera_alt,size: 50,color: Colors.grey,),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width/3.2,
//                 height: MediaQuery.of(context).size.height/5.9,
//                 child: Card(
//                   color: Colors.grey.shade200,
//                   elevation: .25,
//                   child: imageFile.isNotEmpty ? ListView.builder(
//                       itemCount: imageFile.length,
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context,index) {
//                         return Container(
//                             width: MediaQuery.of(context).size.width/3.5,
//                             margin: const EdgeInsets.only(left: 5),
//                             child: Image.file(File(imageFile[index].path),fit: BoxFit.fill,height: MediaQuery.of(context).size.height/4.4,));
//                       }) :
//                   const Icon(FontAwesomeIcons.solidImages,size: 55,color: Colors.grey,),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }















import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart'; // <-- Make sure to import this!
import 'package:survey/utils/title_text.dart';

class ImageListButtonForSurvey extends StatelessWidget {
  const ImageListButtonForSurvey({
    super.key,
    required this.imageFile,
    required this.onSelectImage,
    required this.isRequried,
    required this.onDeleteImage,
  });

  final RxList<File> imageFile; // ✅ RxList instead of regular List
  final Function onSelectImage;
  final bool isRequried;
  final Function(int index) onDeleteImage;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isRequried)
          const Row(
            children: [
              TitleText(title: " Take Image ", color: Colors.black),
              TitleText(title: "*", color: Colors.redAccent),
            ],
          )
        else
          const SizedBox(height: 8),

        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth / 3,
              height: screenHeight / 6,
              child: InkWell(
                onTap: () => onSelectImage(),
                child: Card(
                  color: Colors.grey.shade200,
                  elevation: 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: SizedBox(
                height: screenHeight / 6,
                child: Obx(() {
                  if (imageFile.isNotEmpty) {
                    return ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageFile.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                imageFile[index],
                                width: screenWidth / 3.5,
                                height: screenHeight / 6,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => onDeleteImage(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    size: 28,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Card(
                      color: Colors.grey.shade200,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.solidImages,
                          size: 55,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

