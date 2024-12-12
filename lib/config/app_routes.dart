import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyectofinal/presentation/screens/home/home_screen.dart';
import 'package:proyectofinal/presentation/screens/home/categorias_view/categorias_view.dart';
import 'package:proyectofinal/presentation/screens/login/login_screen.dart';
import 'package:proyectofinal/presentation/screens/productos/detalleproducto.dart';
import 'package:proyectofinal/presentation/screens/productos/formularioproducto.dart';
import 'package:proyectofinal/presentation/screens/productos/listaproductos.dart';
import 'package:proyectofinal/presentation/screens/register/register_screen.dart';
import 'package:proyectofinal/presentation/screens/shop/shop_create_screen.dart';
import 'package:proyectofinal/presentation/screens/shop/shop_detail_screen.dart';
import 'package:proyectofinal/presentation/screens/shop/shop_list_screen.dart';
import 'package:proyectofinal/presentation/screens/sucursales/map_view.dart';
import 'package:proyectofinal/presentation/screens/welcome/welcome_screen.dart';


final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Welcome screen
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),

    
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterScreen(),
    ),

    // Home
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),

    // Categories and Map
    GoRoute(
      path: '/categories/:categoryId/map',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId'];
        if (categoryId == null) {
          throw Exception("Category ID no proporcionado.");
        }
        return MapView(categoryId: categoryId);
      },
    ),

    // Shops
    GoRoute(
      path: '/shops',
      builder: (context, state) => ShopListScreen(),
    ),
    GoRoute(
      path: '/shop/details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        if (id == null) {
          throw Exception("ID no proporcionado.");
        }
        return StoreDetailScreen(storeId: id);
      },
    ),
    GoRoute(
      path: '/shop/create',
      builder: (context, state) => ShopCreateScreen(),
    ),

    // Products
    GoRoute(
      path: '/productos/:storeId',
      builder: (context, state) {
        final storeId = state.pathParameters['storeId'];
        if (storeId == null) {
          throw Exception("storeId no proporcionado.");
        }
        return ProductListScreen(storeId: storeId);
      },
    ),
    GoRoute(
      path: '/productos/:storeId/crear',
      builder: (context, state) {
        final storeId = state.pathParameters['storeId'];
        if (storeId == null) {
          throw Exception("storeId no proporcionado.");
        }
        return ProductFormScreen(storeId: storeId);
      },
    ),
    GoRoute(
      path: '/productos/detalles/:productId',
      builder: (context, state) {
        final productId = state.pathParameters['productId'];
        if (productId == null) {
          throw Exception("productId no proporcionado.");
        }
        return DetalleProductoPage(productId: productId);
      },
    ),
  ],
);
