import 'package:flutter/material.dart';

import '../models/subject.dart';
import '../screens/home_screen.dart';
import '../screens/subject_details_screen.dart';
import 'app_route_names.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<Object?> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppRouteNames.home => _buildRoute(
        settings: settings,
        builder: (_) => const HomeScreen(),
      ),
      AppRouteNames.subjectDetails => _buildSubjectDetailsRoute(settings),
      _ => _buildRoute(settings: settings, builder: (_) => const HomeScreen()),
    };
  }

  static MaterialPageRoute<Object?> _buildSubjectDetailsRoute(
    RouteSettings settings,
  ) {
    final arguments = settings.arguments;
    if (arguments is Subject) {
      return _buildRoute(
        settings: settings,
        builder: (_) => SubjectDetailsScreen(subject: arguments),
      );
    }

    return _buildRoute(settings: settings, builder: (_) => const HomeScreen());
  }

  static MaterialPageRoute<Object?> _buildRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute<Object?>(settings: settings, builder: builder);
  }
}
