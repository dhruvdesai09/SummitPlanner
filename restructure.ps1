# Go to lib folder
Set-Location lib

Write-Host "🔧 Creating folder structure..."

# Create directories
$folders = @(
  "core",
  "data\models", "data\services", "data\repositories",
  "features\auth\screens", "features\auth\widgets", "features\auth\controllers",
  "features\profile\screens", "features\profile\widgets", "features\profile\controllers",
  "features\goals\screens", "features\goals\widgets", "features\goals\controllers",
  "features\home\screens",
  "routing"
)

foreach ($folder in $folders) {
  New-Item -ItemType Directory -Path $folder -Force | Out-Null
}

# Move Dart files to new locations if they exist
Write-Host "🚚 Moving Dart files..."

if (Test-Path "profile_screen.dart") {
  Move-Item "profile_screen.dart" "features\profile\screens\"
}
if (Test-Path "edit_profile.dart") {
  Move-Item "edit_profile.dart" "features\profile\screens\"
}
if (Test-Path "widgets\profile_card.dart") {
  Move-Item "widgets\profile_card.dart" "features\profile\widgets\"
}
if (Test-Path "profile_updater.dart") {
  Move-Item "profile_updater.dart" "features\profile\controllers\"
}
if (Test-Path "user_model.dart") {
  Move-Item "user_model.dart" "data\models\"
}
if (Test-Path "api.dart") {
  Move-Item "api.dart" "data\services\"
}
if (Test-Path "home_screen.dart") {
  Move-Item "home_screen.dart" "features\home\screens\"
}

# Create placeholder files
New-Item -ItemType File core\constants.dart -Force | Out-Null
New-Item -ItemType File core\theme.dart -Force | Out-Null
New-Item -ItemType File core\utils.dart -Force | Out-Null
New-Item -ItemType File data\repositories\.gitkeep -Force | Out-Null
New-Item -ItemType File features\auth\screens\.gitkeep -Force | Out-Null
New-Item -ItemType File features\auth\widgets\.gitkeep -Force | Out-Null
New-Item -ItemType File features\auth\controllers\.gitkeep -Force | Out-Null
New-Item -ItemType File features\goals\screens\.gitkeep -Force | Out-Null
New-Item -ItemType File features\goals\widgets\.gitkeep -Force | Out-Null
New-Item -ItemType File features\goals\controllers\.gitkeep -Force | Out-Null

# Create app.dart
Set-Content -Path "app.dart" -Value @"
import 'package:flutter/material.dart';
import 'routing/app_router.dart';
import 'core/theme.dart';

class SummitPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SummitPlanner',
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
"@

# Create app_router.dart
Set-Content -Path "routing\app_router.dart" -Value @"
import 'package:flutter/material.dart';
import '../features/home/screens/home_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('No route defined for this path')),
          ),
        );
    }
  }
}
"@

Write-Host "✅ Restructure complete!"
