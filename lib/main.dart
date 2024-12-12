import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:proyectofinal/domain/datasources/category_datasource.dart';
import 'package:proyectofinal/domain/datasources/producto_datasource.dart';
import 'package:proyectofinal/domain/datasources/store_datasource.dart';
import 'package:proyectofinal/domain/providers/branch_provider.dart';
import 'package:proyectofinal/domain/providers/category_provider.dart';
import 'package:proyectofinal/domain/providers/producto_provider.dart';
import 'package:proyectofinal/domain/providers/store_provider.dart';
import 'package:proyectofinal/domain/providers/user_provider.dart';
import 'config/app_routes.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
final storeDatasource = StoreDatasource(); 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(CategoryDatasource()),
        ),
        ChangeNotifierProvider(create: (_) => BranchProvider()),
        ChangeNotifierProvider(create: (_) => StoreProvider(storeDatasource)
        ), 
        ChangeNotifierProvider(create: (_) => UserProvider()
        ),
        ChangeNotifierProvider(
            create: (_) => ProductProvider(ProductDatasource()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Material App',
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  
}
