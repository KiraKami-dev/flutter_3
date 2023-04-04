import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/provider/viewed_prod_provider.dart';
import 'package:grocery_app/screens/view_recently/viewed_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/utils.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    final viewedlistProvider = Provider.of<ViewedProdProvider>(context);
    final viewedlistItemsList = viewedlistProvider.getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();
    // Size size = Utils(context).getScreenSize;
    if (viewedlistItemsList.isEmpty) {
      return const EmptyScreen(
        imagePath: "images/emptybox.png",
        title: "No viewed Product",
        subtitle: "Check View product here",
        buttonText: "View products",
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                GlobalMethod.warningDialog(
                    title: 'Empty your history?',
                    subtitle: 'Are you sure?',
                    context: context,
                    ftc: () {});
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ),
            )
          ],
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: TextWidget(
            text: 'History',
            color: color,
            textSize: 24.0,
          ),
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        body: ListView.builder(
            itemCount: viewedlistItemsList.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: ChangeNotifierProvider.value(
                    value: viewedlistItemsList[index],
                    child: ViewedRecentlyWidget()),
              );
            }),
      );
    }
  }
}
