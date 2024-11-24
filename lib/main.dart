import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/state/appState.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/navigator/routes.dart';
import 'package:heartmonitor/ui/pages/common/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupDependencies();
  runApp(const HeartRateMonitor());
}

class HeartRateMonitor extends StatelessWidget {
  const HeartRateMonitor({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
      ],
      child: MaterialApp(
        title: 'Heart Monitor',
        theme: AppTheme.appTheme.copyWith(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: Routes.route(),
        onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
        onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
        initialRoute: "SplashPage",
      ),
    );
  }
}
