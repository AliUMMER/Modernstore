import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modern_grocery/bloc/AddToWishlist_bloc/add_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/CreateBanner_bloc/create_banner_bloc.dart';


import 'package:modern_grocery/bloc/GetAllBannerBloc/get_all_banner_bloc.dart';
import 'package:modern_grocery/bloc/GetAllCategories/bloc/get_all_categories_bloc.dart';


import 'package:modern_grocery/bloc/GetAllUserCart/get_all_user_cart_bloc.dart';


import 'package:modern_grocery/bloc/GetById/getbyid_bloc.dart';

import 'package:modern_grocery/bloc/GetCategoryProducts/get_category_products_bloc.dart';

import 'package:modern_grocery/bloc/GetToWishlist_bloc/get_to_wishlist_bloc.dart';
import 'package:modern_grocery/bloc/addCart_bloc/add_cart_bloc.dart';
import 'package:modern_grocery/bloc/addDeliveryAddress/add_delivery_address_bloc.dart';
import 'package:modern_grocery/bloc/createCategory/create_category_bloc.dart';
import 'package:modern_grocery/bloc/createProduct/create_product_bloc.dart';
import 'package:modern_grocery/bloc/get_all_product/get_all_product_bloc.dart';
import 'package:modern_grocery/bloc/login/login_bloc.dart';
import 'package:modern_grocery/bloc/offerproduct/offerproduct_bloc.dart';
import 'package:modern_grocery/bloc/userdelivery%20addrees/userdeliveryaddress_bloc.dart';
import 'package:modern_grocery/bloc/userprofile/bloc/userprofile_bloc.dart';
import 'package:modern_grocery/repositery/api/addCart_api.dart';
import 'package:modern_grocery/repositery/api/api_client.dart';
import 'package:modern_grocery/repositery/api/createCategory_api.dart';
import 'package:modern_grocery/repositery/api/createbanner_api.dart';
import 'package:modern_grocery/repositery/api/getbyidproduct_api.dart';
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
              create: (context) => AddCartBloc(
                addCartApi: AddcartApi(apiClient: ApiClient()),
              ),
            ),
            BlocProvider(
              create: (context) =>
                  GetbyidBloc(getbyidproductApi: GetbyidproductApi()),
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
              create: (context) => CreateBannerBloc(api: CreatebannerApi()),
            ),
            BlocProvider(
              create: (context) => GetCategoryProductsBloc(),
            ),
            BlocProvider(
              create: (context) => GetAllUserCartBloc(),
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
