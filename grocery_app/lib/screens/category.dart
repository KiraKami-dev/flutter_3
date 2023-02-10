import 'package:flutter/material.dart';
import 'package:grocery_app/widgets/categories_widget.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

class Categories extends StatelessWidget {
   Categories({Key? key}) : super(key: key);
    List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];
List<Map<String, dynamic>> catInfo = [
    {
      'imgpath': "images/cat/cabbage.png",
      'cattext': "Cabbage",
    },
    {
      'imgpath': "images/cat/kyoto.png",
      'cattext': "Kyoto",
    },
    {
      'imgpath': "images/cat/onion.png",
      'cattext': "onion",
    },
    {
      'imgpath': "images/cat/spinach.png",
      'cattext': "Spinach",
    },
    {
      'imgpath': "images/cat/tomato.png",
      'cattext': "tomato",
    },
    {
      'imgpath': "images/cat/strawberry.png",
      'cattext': "strawberry",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: "Categories",
          color: color,
          textSize: 24,
          isTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 10, //vertical
          mainAxisSpacing: 10,  //horizontal
          children: List.generate(6, (index) {
            return CategoriesWidgets(
              catText: catInfo[index]['cattext'],
              imgPath: catInfo[index]['imgpath'],
              passedColor: gridColors[index]
            );
          }),
        ),
      ),
    );
  }
}
