import 'package:flutter/material.dart';
import 'package:pro2/global/color.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryColor6,
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
        title: Text(
          'About us',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: ColorManager.primaryColor8,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.purple[100],
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Many people experience stress and confusion when planning events due to the multitude of options and time constraints. '
              'Our team noticed a significant opportunity to create an easy-to-use application that ensures customer satisfaction in the shortest time and at the lowest cost.'
              'We present to you the operational mechanism and features of our application'
              ' designed to overcome the pitfalls of existing services in this domain. Additionally,'
              "we'll discuss the challenges our team faced and how we overcame them.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'At Instavent, our mission is to revolutionize event planning by providing a seamless and efficient platform that empowers our users to create memorable experiences effortlessly .',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Our Vision',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'To be a leading provider of high-quality services '
              'that enable our customers to achieve their goals.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
