
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:login_task/features/categories/cubit/login_cubit.dart';
import 'features/categories/view/login_view.dart';
import 'network/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('authBox');

  DioHelper().initialization();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommerce',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginView(),
      ),
    );
  }
}
