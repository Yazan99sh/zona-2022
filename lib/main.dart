import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zona/src/features/controller/social_sign_in.dart';
import 'package:zona/generated/l10n.dart';
import 'package:zona/l10n/l10n.dart';
import 'package:zona/src/features/view/screens/block_screens/no_pay_screen_for_guest.dart';
import 'package:zona/src/features/view/screens/signIn_signUp_verifyCode_screens/signIn_screen.dart';
import 'package:zona/src/features/view/screens/signIn_signUp_verifyCode_screens/signUp_screen.dart';
import 'package:zona/src/features/view/screens/signIn_signUp_verifyCode_screens/verify_code_screen.dart';
import 'package:zona/src/features/view/screens/onboarding_screens/onboarding_screen.dart';
import 'package:zona/src/features/view/screens/main_app_screens/home_layout_screen/home_layout_screen.dart';
import 'package:zona/src/features/view/screens/terms_of_use_screen/terms_of_use_Screen.dart';
import 'package:zona/src/providers/delete_account_provider.dart';
import 'package:zona/src/providers/draft_provider.dart';
import 'package:zona/src/providers/home_provider.dart';
import 'package:zona/src/providers/logout_provider.dart';
import 'package:zona/src/providers/register_provider.dart';
import 'package:zona/src/utils/responsive.dart';
import 'package:zona/src/utils/themes/light_theme.dart';
import 'firebase_options.dart';
import 'src/features/models/user.dart' as userModel;
import 'src/features/controller/stripe_controller.dart';
import 'src/features/view/screens/block_screens/no_perrmission_selected_or_denied.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = 'pk_test_51LCqzTC7fd3offI0jSy9lHLnjP5WMi3lX2Wr7FwjOki7WKvVKEYkc9LvD43cgpYJYBdqPPHsMrN7I8vryFA6X9Xy00uyaeGcMJ';
  Stripe.publishableKey =
      'pk_live_51LCqzTC7fd3offI0EjAZp3xkpZr350kPE3eFqVwQDlB5L0ry1AaQoqqgBs9m9M8DJL9DO1dgqWfMlWO53tiHx5Zf009PyAhNFQ';
  Stripe.merchantIdentifier = 'merchant.stripe-zona.ae';
  await Firebase.initializeApp(
    name: "The-Zona",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then(
    (_) => runApp(
      const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool intro = false;

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SocialSignInProvider>(
          create: (_) => SocialSignInProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider<DraftProvider>(
          create: (_) => DraftProvider(),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider<LogoutProvider>(
          create: (_) => LogoutProvider(),
        ),
        ChangeNotifierProvider<DeleteAccountProvider>(
          create: (_) => DeleteAccountProvider(),
        ),
      ],
      child: MaterialApp(
        theme: AppLightTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        // home: const MyHomePage(),
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        initialRoute: '/splash',
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          '/splash': (context) => const MyHomePage(),
          VerifyCodeScreen.id: (context) => const VerifyCodeScreen(
                email: '',
              ),
          SignInScreen.id: (context) => const SignInScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          "/noPermissionScreenRoute": (context) =>
              const NoPermissionFromUserScreen(),
          "/noPayForGuest": (context) => const NoPayForGuest(),
          "/TermsOfUse": (context) => TermsOfUseScreen(),
        },
        // home:ProfileScreen() ,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool intro = false;
  bool logged = false;
  int id = -1;
  String userJson = '';
  userModel.MyUser user = userModel.MyUser();

  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    intro = prefs.getBool("SeenIntro") ?? false;
    logged = prefs.getBool("Logged") ?? false;
    setState(() {});
    if (prefs.getString("user") != null) {
      setState(() {
        userJson = prefs.getString("user")!;
        user = userModel.MyUser.fromJson(jsonDecode(userJson));
      });
    }
  }

  @override
  void initState() {
    getSharedPrefs();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if (logged) {
          return const HomeScreen();
        } else if (intro) {
          return const SignInScreen();
        } else {
          return const OnBoardingScreens();
        }
      }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "zona",
              child: Image.asset(
                "assets/images/ZonaLogo.png",
                width: Responsive.getScreenWidth(context) * 0.8,
                height: Responsive.getScreenHeight(context) * 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
