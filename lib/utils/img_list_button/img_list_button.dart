import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:survey/utils/title_text.dart';

class ImageListButtonForSurvey extends StatelessWidget {
  const ImageListButtonForSurvey({super.key,required this.imageFile,required this.onSelectImage, required this.isRequried});
  final List<File> imageFile;
  final Function onSelectImage;
  final bool isRequried;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isRequried? const Row(
          children: [
            TitleText(title: " Take Image ", color: Colors.black,),
            TitleText(title: "*", color: Colors.redAccent,)
          ],
        ):const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width/3,
              height: MediaQuery.of(context).size.height/6,
              child: InkWell(
                onTap: () {
                  onSelectImage();
                },
                child: Card(
                  color: Colors.grey.shade200,
                  elevation: .25,
                  child:const Icon(Icons.camera_alt,size: 50,color: Colors.grey,),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width/3.2,
                height: MediaQuery.of(context).size.height/5.9,
                child: Card(
                  color: Colors.grey.shade200,
                  elevation: .25,
                  child: imageFile.isNotEmpty ? ListView.builder(
                      itemCount: imageFile.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index) {
                        return Container(
                            width: MediaQuery.of(context).size.width/3.5,
                            margin: const EdgeInsets.only(left: 5),
                            child: Image.file(File(imageFile[index].path),fit: BoxFit.fill,height: MediaQuery.of(context).size.height/4.4,));
                      }) :
                  const Icon(FontAwesomeIcons.solidImages,size: 55,color: Colors.grey,),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}