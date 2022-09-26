import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/component/components.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.title, required this.body, required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        title: "On Board1 Title",
        body: "On Board1 Body",
        image: "assets/images/onboard_1.jpg"),
    BoardingModel(
        title: "On Board2 Title",
        body: "On Board2 Body",
        image: "assets/images/onboard_1.jpg"),
    BoardingModel(
        title: "On Board3 Title",
        body: "On Board3 Body",
        image: "assets/images/onboard_1.jpg"),
  ];
  bool isLast = false;

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DefaultTextButton(
            function: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ShopLoginScreen()),
                      (Route<dynamic> route) => false);
            },
            text: "skip",
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) {
                  return buildBoardingItem(
                    model: boarding[index],
                  );
                },
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => ShopLoginScreen()),
                              (Route<dynamic> route) => false);
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class buildBoardingItem extends StatelessWidget {
  BoardingModel model;

  buildBoardingItem({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage("${model.image}"),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Text(
          "${model.title}",
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "${model.body}",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
