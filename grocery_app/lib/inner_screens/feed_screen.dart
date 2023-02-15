import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';

import '../widgets/feed_item.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);
  static const routeName = "/FeedScreen";

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController? _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  @override
  void dispose() {
    _searchController!.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getsize;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: TextWidget(
          text: "All products",
          color: color,
          textSize: 20,
          isTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: (valuee) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.greenAccent,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.greenAccent, width: 1),
                      ),
                      hintText: "Search here",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        icon: const Icon(Icons.close),
                        color: _searchFocusNode.hasFocus ? Colors.red : color,
                        onPressed: () {
                          _searchController!.clear();
                          _searchFocusNode.unfocus();
                        },
                      )),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / (size.height * 0.60),
              children: List.generate(
                4,
                (index) {
                  return const FeedWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
