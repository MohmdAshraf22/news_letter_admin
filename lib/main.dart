import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'core/services/dep_injection.dart';
import 'core/services/firebase_options.dart';
import 'core/utils/theme_manager.dart';
import 'module/presentation_layer/bloc/main_bloc.dart';
import 'module/presentation_layer/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<MainBloc>(
              create: (BuildContext context) => sl()
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getAppTheme(),
          home: const MainScreen(),
        ),
      );
    });
  }
}
