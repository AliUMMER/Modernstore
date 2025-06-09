import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/AddToWishlist_bloc/add_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/CreateBanner_bloc/bloc/create_banner_bloc.dart';
import 'package:modern_grocery/bloc/CreateCategory/bloc/create_category_bloc.dart';
import 'package:modern_grocery/bloc/GetAllBannerBloc/bloc/get_all_banner_bloc.dart';
import 'package:modern_grocery/bloc/GetAllCategories/bloc/get_all_categories_bloc.dart';
import 'package:modern_grocery/bloc/GetById/bloc/getbyid_bloc.dart';
import 'package:modern_grocery/bloc/GetToWishlist_bloc/bloc/get_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:modern_grocery/bloc/addDeliveryAddress/bloc/add_delivery_address_bloc.dart';
import 'package:modern_grocery/bloc/createProduct/bloc/create_product_bloc.dart';
import 'package:modern_grocery/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:modern_grocery/bloc/login/bloc/login_bloc.dart';
import 'package:modern_grocery/bloc/offerproduct/offerproduct_bloc.dart';
import 'package:modern_grocery/bloc/userdelivery%20addrees/userdeliveryaddress_bloc.dart';
import 'package:modern_grocery/bloc/userprofile/bloc/userprofile_bloc.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/api/createCategory_api.dart';
import 'package:modern_grocery/ui/splash_screen.dart';

// String basePath = "http://192.168.223.203:4055/api";
// String basePath = "http://69.62.79.175:4735/api";
String basePath = "https://modern-store-backend.onrender.com/api";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 917),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(),
            ),
            BlocProvider(
              create: (context) => GetAllCategoriesBloc(),
            ),
            BlocProvider(
              create: (context) => AddDeliveryAddressBloc(),
            ),
            BlocProvider(
              create: (context) => AddCartBloc(),
            ),
            BlocProvider(
              create: (context) => GetbyidBloc(),
            ),
            BlocProvider(
              create: (context) => GetAllBannerBloc(),
            ),
            BlocProvider(
              create: (context) => CreateCategoryBloc(
                createcategoryApi: CreatecategoryApi(apiClient: ApiClient()),
              ),
            ),
            BlocProvider(create: (context) => CreateProductBloc()),
            BlocProvider(
              create: (context) => GetAllProductBloc(),
            ),
            BlocProvider(
              create: (context) => UserprofileBloc(),
            ),
            BlocProvider(
              create: (context) => UserdeliveryaddressBloc(),
            ),
            BlocProvider(
              create: (context) => OfferproductBloc(),
            ),
            BlocProvider(
              create: (context) => AddToWishlistBloc(),
            ),
            BlocProvider(
              create: (context) => GetToWishlistBloc(),
            ),
            BlocProvider(
              create: (context) => CreateBannerBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
