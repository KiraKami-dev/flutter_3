import 'package:flutter/material.dart';
import 'package:grocery_app/inner_screens/feed_screen.dart';
import 'package:grocery_app/inner_screens/on_sale_screen.dart';
import 'package:grocery_app/inner_screens/product_details.dart';
import 'package:grocery_app/provider/dark_theme_provider.dart';
import 'package:grocery_app/screens/auth/forget_pass.dart';
import 'package:grocery_app/screens/auth/login.dart';
import 'package:grocery_app/screens/auth/register.dart';
import 'package:grocery_app/screens/btm_bar.dart';
import 'package:grocery_app/screens/orders/orders_screen.dart';
import 'package:grocery_app/screens/view_recently/viewed_recently.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return themeChangeProvider;
          },
        )
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const BottomBar(),
          routes: {
            OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
            FeedScreen.routeName:(ctx)=> const FeedScreen(),
            ProductDetails.routeName:(ctx)=> const ProductDetails(),
            WishListScreen.routeName:(ctx)=> const WishListScreen(),
            OrdersScreen.routeName : (ctx)=> const OrdersScreen(),
            ViewedRecentlyScreen.routeName:(ctx)=> const ViewedRecentlyScreen(),
            LoginScreen.routeName:(ctx)=> const LoginScreen(),
            RegisterScreen.routeName:(ctx)=> const RegisterScreen(),
            ForgetPasswordScreen.routeName:(ctx)=> const ForgetPasswordScreen(),
          },
        );
      }),
    );
  }
}
