import 'package:flutter/material.dart';
import 'package:grocery_app/models/products_model.dart';
import 'package:grocery_app/provider/products_provider.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_prod.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../widgets/feed_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  static const routeName = "/CategoryScreen";

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController? _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController!.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getsize;
    final catName = ModalRoute.of(context)!.settings.arguments as String;
    final productsProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productByCat = productsProviders.findByCategory(catName);

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
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
      body: productByCat.isEmpty
          ? const EmptyProductWidget(text: "No product available here!",)
          : SingleChildScrollView(
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
                              borderSide: const BorderSide(
                                  color: Colors.greenAccent, width: 1),
                            ),
                            hintText: "Search here",
                            prefixIcon: const Icon(Icons.search),
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              color: _searchFocusNode.hasFocus
                                  ? Colors.red
                                  : color,
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
                      productByCat.length,
                      (index) {
                        return ChangeNotifierProvider.value(
                            value: productByCat[index],
                            child: const FeedWidget());
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
