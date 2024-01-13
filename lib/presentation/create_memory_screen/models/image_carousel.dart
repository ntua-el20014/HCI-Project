import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io'; // Import for File class

class ImageCarousel extends StatelessWidget {
  final List<String> imgList;

  ImageCarousel({required this.imgList});

  @override
  Widget build(BuildContext context) {
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
      items: imgList
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
