import 'package:app_asistencia/config/router/app_router.dart';
import 'package:app_asistencia/config/theme/appTheme.dart';
import 'package:app_asistencia/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider(),)
      ],
      child: MaterialApp.router(
        theme: AppTheme().getTheme(),
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
