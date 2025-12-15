import 'package:englishdz/colors/colors.dart';
import 'package:englishdz/models/level_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<LevelModel> levels = [
    LevelModel(
      title: "BAC",
      subtitle: "Start your journey",
      image: "images/on1.png",
      color: primaryColor,
    ),
    LevelModel(
      title: "BEM",
      subtitle: "Keep going",
      image: "images/on2.png",
      color: secondaryColor,
    ),
    LevelModel(
      title: "A1",
      subtitle: "Almost there",
      image: "images/on3.png",
      color: thirdColor,
    ),
    LevelModel(
      title: "A2",
      subtitle: "Master it",
      image: "images/4.png",
      color: primaryColor,
    ),
    LevelModel(
      title: "B1",
      subtitle: "Test your skills",
      image: "images/5.png",
      color: secondaryColor,
    ),
    LevelModel(
      title: "B2",
      subtitle: "Test your skills",
      image: "images/6.png",
      color: thirdColor,
    ),
    LevelModel(
      title: "C1",
      subtitle: "Test your skills",
      image: "images/7.png",
      color: primaryColor,
    ),
    LevelModel(
      title: "C2",
      subtitle: "Test your skills",
      image: "images/8.png",
      color: thirdColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 241),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //   Padding(padding: EdgeInsetsGeometry.only(left: 10, right: 10)),
            Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Welcome to ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " EnglishDz",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: thirdColor,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      " The place that you",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      " can learn English! ",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: width * 0.2),
                Image.asset(
                  "images/3.png",
                  height: height * 0.35,
                  width: 0.38 * width,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: GridView.builder(
                shrinkWrap: true, // مهم
                physics: const NeverScrollableScrollPhysics(), // مهم
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // عدد الأعمدة
                  crossAxisSpacing: width * 0.04, // المسافة بين الأعمدة
                  mainAxisSpacing: height * 0.04, // المسافة بين الصفوف
                  childAspectRatio: 0.65, // نسبة العرض إلى الارتفاع لكل عنصر
                ),
                itemCount: 8, // عدد العناصر
                itemBuilder: (context, index) {
                  //  final item = items[index];
                  return GridviewB(levelModel: levels[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridviewB extends StatelessWidget {
  GridviewB({super.key, required this.levelModel});

  LevelModel levelModel;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: levelModel.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: levelModel.color!.withOpacity(1), // لون الظل
            spreadRadius: 2, // مدى انتشار الظل
            blurRadius: 8, // نعومة الظل
            offset: const Offset(4, 2), // إزاحة الظل (x, y)
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            levelModel.image,
            height: height * 0.2,
            width: width * 0.35,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            levelModel.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            levelModel.subtitle,
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
