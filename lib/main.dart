import 'package:flutter/material.dart';
import 'package:green_score/provider/general_provider.dart';
import 'package:green_score/provider/user_provider.dart';
import 'package:green_score/services/dialog.dart';
import 'package:green_score/services/navigation.dart';
import 'package:green_score/src/auth/login_page.dart';
import 'package:green_score/src/auth/register_page.dart/register_page.dart';
import 'package:green_score/src/collect_score_page/all_opportunity_page.dart';
import 'package:green_score/src/collect_score_page/opportunity_status_page.dart';
import 'package:green_score/src/home_page/company_page/company_page.dart';
import 'package:green_score/src/home_page/product_detail_page/product_detail_page.dart';
import 'package:green_score/src/main_page.dart';
import 'package:green_score/src/notification_page/notification_page.dart';
import 'package:green_score/src/qr_code_page/qr_code_page.dart';
import 'package:green_score/src/qr_code_page/qr_read_page.dart';
import 'package:green_score/src/qr_code_page/qr_transfer.dart';
import 'package:green_score/src/splash_screen/splash_screen.dart';
import 'package:green_score/src/trade_page/trade_page.dart';
import 'package:green_score/src/wallet_page/card_detail_page/card_detail_page.dart';
import 'package:green_score/src/wallet_page/wallet_page.dart';
import 'package:green_score/widget/dialog_manager/dialog_manager.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  runApp(const MyApp());
}

GetIt locator = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return MaterialApp(
            builder: (context, widget) => Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) =>
                    DialogManager(child: loading(context, widget)),
              ),
            ),
            title: 'Green Score',
            theme: ThemeData(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case SplashScreen.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const SplashScreen();
                  });
                case RegisterPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  });
                case MainPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const MainPage();
                  });
                case LoginPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  });
                case AllOpportunityPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const AllOpportunityPage();
                  });
                case WalletPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const WalletPage();
                  });
                case TradePage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const TradePage();
                  });
                case QrCodePage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const QrCodePage();
                  });
                case NotificationPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const NotificationPage();
                  });
                case QrReadPage.routeName:
                  return MaterialPageRoute(builder: (context) {
                    return const QrReadPage();
                  });
                case QrTransferPage.routeName:
                  QrTransferPageArguments arguments =
                      settings.arguments as QrTransferPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return QrTransferPage(
                      data: arguments.data,
                    );
                  });
                case CardDetailPage.routeName:
                  CardDetailPageArguments arguments =
                      settings.arguments as CardDetailPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CardDetailPage(
                      id: arguments.id,
                      title: arguments.title,
                    );
                  });
                case ProductDetail.routeName:
                  ProductDetailArguments arguments =
                      settings.arguments as ProductDetailArguments;
                  return MaterialPageRoute(builder: (context) {
                    return ProductDetail(
                      name: arguments.name,
                      price: arguments.price,
                      description: arguments.description,
                    );
                  });
                case OpportunityStatusPage.routeName:
                  OpportunityStatusPageArguments arguments =
                      settings.arguments as OpportunityStatusPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return OpportunityStatusPage(
                      id: arguments.id,
                      title: arguments.title,
                      assetPath: arguments.assetPath,
                    );
                  });
                case CompanyPage.routeName:
                  CompanyPageArguments arguments =
                      settings.arguments as CompanyPageArguments;
                  return MaterialPageRoute(builder: (context) {
                    return CompanyPage(
                      name: arguments.name,
                      id: arguments.id,
                    );
                  });
                default:
                  return MaterialPageRoute(
                    builder: (_) => const SplashScreen(),
                  );
              }
            },
          );
        },
      ),
    );
  }
}

Widget loading(BuildContext context, widget) {
  bool shouldPop = false;

  return PopScope(
    canPop: shouldPop,
    child: Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        color: Colors.blue,
        child: SafeArea(
          bottom: false,
          top: false,
          child: Stack(
            children: [
              Opacity(
                opacity: 1,
                child: Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      widget,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
