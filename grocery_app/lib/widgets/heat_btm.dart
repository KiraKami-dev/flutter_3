import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../provider/wishlist_provider.dart';

class HeartBtn extends StatelessWidget {
  const HeartBtn(
      {Key? key, required this.productId, required this.isInWishlist})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return GestureDetector(
      onTap: () {
        wishlistProvider.addRemoveProductToWishlist(productId: productId);
      },
      child: Icon(
        isInWishlist != null && isInWishlist == true ? IconlyBold.heart : IconlyLight.heart,
        size: 22,
        color: isInWishlist != null && isInWishlist == true ? Colors.red : color,
      ),
    );
  }
}
