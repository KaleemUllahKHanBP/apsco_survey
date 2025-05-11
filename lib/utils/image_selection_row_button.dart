import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:survey/res/app_color.dart';

class ImageRowButton extends StatelessWidget {
  const ImageRowButton({super.key,required this.imagePath,required this.onSelectImage,required this.isRequired});
  final String? imagePath;
  final Function onSelectImage;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Row(
              children: [
                Text("Take Photo",style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,fontSize: 15),),
                  Text(" *", style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,fontSize: 17),)
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width/2.4,
              height: MediaQuery.of(context).size.height/5.9,
              child: InkWell(
                onTap: () {
                  onSelectImage();
                },
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Icon(Icons.camera_alt_rounded,size: 100,color: Colors.grey.shade200,),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text("View Photo",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,fontSize: 15),),
            SizedBox(
              width: MediaQuery.of(context).size.width/2.4,
              height: MediaQuery.of(context).size.height/5.9,
              child: Card(
                color: Colors.white,
                elevation: 1,
                child: imagePath != ""? Image.file(File(imagePath!),fit: BoxFit.fill,) :
                Icon(Icons.image_outlined,size: 100,color: Colors.grey.shade200,),
              ),

            ),
          ],
        ),
      ],
    );
  }
}
class ImageListButton extends StatelessWidget {
  const ImageListButton({super.key,required this.imageFile,required this.isDeleteShow,required this.onDeleteItem,required this.onSelectImage,required this.onGalleryList});
  final List<File> imageFile;
  final Function onSelectImage;
  final Function onGalleryList;
  final Function(int index) onDeleteItem;
  final bool isDeleteShow;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              onSelectImage();
            },
            child: Column(
              children: [
                Text("Take Photo".tr),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/6,
                    width: MediaQuery.of(context).size.width/2.2,
                    child: Image.asset("assets/icons/camera_icon.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: (){
              onGalleryList();
            },
            child: Column(
              children: [
                Text("View Photo".tr),
                Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Container(
                      height: MediaQuery.of(context).size.height/6,
                      width: MediaQuery.of(context).size.width/2.2,
                      color: Colors.white,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          imageFile.isNotEmpty ? ListView.builder(
                              itemCount: imageFile.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index) {
                                return Container(
                                    margin:const EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 5
                                    ),
                                    child: Stack(
                                      children: [
                                        Image.file(File(imageFile[index].path),fit: BoxFit.fill,height: MediaQuery.of(context).size.height/4.4,),
                                        if(isDeleteShow)
                                        Positioned(
                                            left: 2,
                                            top: 2,
                                            child: InkWell(
                                              onTap: (){
                                                onDeleteItem(index);
                                              },
                                              child: Container(
                                              decoration: BoxDecoration(
                                                color:appMainColorDark,
                                                borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: const Icon(Icons.clear,color:appMainColorDark,)),
                                            ))
                                      ],
                                    ));
                              }) : Image.asset("assets/icons/gallery_icon.png"),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}