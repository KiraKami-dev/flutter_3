import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/screens/wishlist/wishlisht_widget.dart';
import 'package:grocery_app/widgets/back_widget.dart';
import 'package:grocery_app/widgets/empty_screen.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../services/global_methods.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = '/WislListScreen';
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    // final theme = Utils(context).getTheme;
    // Size size = Utils(context).getsize;
    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
            imagePath: "images/emptybox.png",
            title: "Empty Wishlist",
            subtitle: "Looks like your wishlist is empty",
            buttonText: "Add a wish",
          )
        : Scaffold(
            appBar: AppBar(
                centerTitle: true,
                leading: const BackWidget(),
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: TextWidget(
                  text: "WishList ${wishlistItemsList.length}",
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      GlobalMethod.warningDialog(
                          title: "Empty Wishlist",
                          subtitle: 'are you sure?',
                          ftc: () {
                            wishlistProvider.clearCart();
                          },
                          context: context,
                          imgadd: "images/logout.png");
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ),
                  ),
                ]),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 4,
              // crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
              },
            ));
  }
}

// Widget _checkcut({
//   required size,
//   required color,
// }) {
//   return SizedBox(
//     width: double.infinity,
//     height: size.height * 0.08,
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: Row(
//         children: [
//           Material(
//             color: Colors.green,
//             borderRadius: BorderRadius.circular(10),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(10),
//               onTap: () {},
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextWidget(
//                   text: "Order Now",
//                   color: Colors.white,
//                   textSize: 20,
//                 ),
//               ),
//             ),
//           ),
//           const Spacer(),
//           FittedBox(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextWidget(
//                 text: "Total \$0.259",
//                 color: color,
//                 textSize: 18,
//                 isTitle: true,
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
