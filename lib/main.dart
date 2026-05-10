import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_strings.dart';
import 'providers/gradebook_provider.dart';
import 'routes/app_route_names.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GradebookProvider(),
      child: MaterialApp(
        title: AppStrings.appTitle,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        initialRoute: AppRouteNames.home,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
