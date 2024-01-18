import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // Import for File class

// ignore: must_be_immutable
class ImageCarousel extends StatefulWidget {
  List<String> imgList;

  ImageCarousel({
    Key? key,
    required this.imgList,
  }) : super(key: key);

  @override
  ImageCarouselState createState() => ImageCarouselState();
}

class ImageCarouselState extends State<ImageCarousel> {
  List<String>? imgList;
  void initState() {
    super.initState();
    imgList = widget.imgList;
  }

  void updateImages({List<String>? imgList}) {
    setState(() {
      
      this.imgList = imgList ?? this.imgList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imgList.isEmpty) {
      // Display a placeholder image when imgList is empty
      return Container(
        width: 100,
        height: 100,
        child: _buildImage('assets/images/image_not_found.png'),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.5, // Adjust the aspect ratio
        autoPlay: false,
        animateToClosest: false,
        enableInfiniteScroll: false,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        pageSnapping: false,
        viewportFraction: 0.65,
      ),
      items: widget.imgList
          .map((item) => Container(
                child: Center(
                  child: _buildImage(item),
                ),
              ))
          .toList(),
    );
  }

  // Helper method to build the image based on the source
  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('assets/')) {
      // Load from assets
      return Image.asset(imagePath, fit: BoxFit.cover);
    } else {
      // Load from local file
      return Image.file(File(imagePath), fit: BoxFit.cover);
    }
  }
}
