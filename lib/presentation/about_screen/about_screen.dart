import 'package:anamnesis/core/app_export.dart';
import 'package:anamnesis/widgets/app_bar/appbar_leading_image.dart';
import 'package:anamnesis/widgets/app_bar/appbar_subtitle.dart';
import 'package:anamnesis/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return AboutScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildContent(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        color: Colors.black,
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 12.v,
          bottom: 12.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "About Anamnesis".tr,
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildIntroBox(),
          SizedBox(height: 16.0),
          Expanded(
            child: _buildMainContentBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroBox() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '''
          An app made by
          Mike Raftopoulos
          and Nick Oikonomou''',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildMainContentBox() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            '''
            This app lets you store your memories. You can add all kinds of them, including trips, places or events. Browse your collection and quickly recall your favorite ones.
            
            Offline access to your own time capsule or memory box someone might say. Add the location and watch your memory map fill with pins and pictures from your journeys. Also, write or record your thoughts in your personal journal. This way you can keep track of everything important and revisit at anytime.
            
            Never forget a place or a face, a name or a moment, a food or a city. Expand your gallery collection with new albums and enjoy your adventure along the way.
            
            Also, plan ahead. Add upcoming events or trips. Take a moment to review them afterwards. Write down your opinion. Everything you experience matters and that’s why you need this app.
            
            Expand your own physical memory into your device and never forget a thing. This way you can share with friends and family all about your life. You can be a storyteller, the person that everybody wants to talk to, that has something new to say every time.
            
            Anamnesis is made for you!
            ''',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
