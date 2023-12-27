import 'package:joiner_1/app_state.dart';
import 'package:joiner_1/flutter_flow/nav/nav.dart';
import 'package:joiner_1/pages/cra/rentals/cra_rentals_widget.dart';
import 'package:joiner_1/utils/custom_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'index.dart';
import 'pages/cra/car/cra_car_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: appState,
        ),
        ChangeNotifierProvider(
          create: (context) => AppStateNotifier.instance,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  late FFAppState _appState;
  late AppStateNotifier _appStateNotifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _appState = context.watch<FFAppState>();
    _appStateNotifier = Provider.of<AppStateNotifier>(context);
    return MaterialApp.router(
      title: 'Joiner 1',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: lightTheme(context),
      routerConfig: GoRouter(
        initialLocation: '/login',
        debugLogDiagnostics: true,
        refreshListenable: _appStateNotifier,
        errorBuilder: (context, state) {
          print('${state.error} ${state.fullPath}');
          return LoginPageWidget();
        },
        routes: _appStateNotifier.routes,
            // .map((r) => r.routes)
            // .toList(),
        redirect: (context, state) {
          return _appStateNotifier.redirectState(context, state, _appState);
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'Login';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FFAppState>(
      builder: (context, value, child) {
        return value.isCra ? craDashboard() : userDashboard();
      },
    );
  }

  Widget userDashboard() {
    final tabs = {
      'MainDashboard': LobbiesWidget(),
      'CarRentals': RentalsWidget(),
      'Friends': FriendsWidget(),
      'Account': AccountWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: SafeArea(
        child: tabs[_currentPageName]!,
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        color: Colors.transparent,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: GNav(
              selectedIndex: currentIndex,
              onTabChange: (i) => setState(() {
                _currentPage = null;
                _currentPageName = tabs.keys.toList()[i];
              }),
              color: Colors.grey,
              activeColor: Theme.of(context).primaryColor,
              tabBackgroundColor:
                  Theme.of(context).colorScheme.primaryContainer,
              padding: EdgeInsetsDirectional.all(10),
              gap: 8,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              duration: Duration(milliseconds: 500),
              haptic: false,
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
              tabs: [
                GButton(
                  icon: Icons.meeting_room_rounded,
                  text: 'Lobby',
                ),
                GButton(
                  icon: Icons.directions_car,
                  text: 'Rentals',
                ),
                GButton(
                  icon: Icons.people_alt_outlined,
                  text: 'Friends',
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: 'Account',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget craDashboard() {
    final tabs = {
      'Cars': CraCarWidget(),
      'CraRentals': CraRentalsWidget(),
      'Account': AccountWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: SafeArea(child: _currentPage ?? tabs[_currentPageName]!),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              offset: const Offset(
                0.0,
                -1.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: GNav(
          selectedIndex: currentIndex,
          onTabChange: (i) => setState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
          color: Colors.grey,
          activeColor: Theme.of(context).primaryColor,
          tabBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          padding: EdgeInsetsDirectional.all(10),
          gap: 8,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          duration: Duration(milliseconds: 500),
          haptic: false,
          tabMargin: EdgeInsets.all(10),
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
          tabs: [
            GButton(
              icon: Icons.directions_car,
              text: 'Cars',
              iconSize: 24.0,
            ),
            GButton(
              icon: Icons.receipt_rounded,
              text: 'Rentals',
              iconSize: 24.0,
            ),
            GButton(
              icon: Icons.person,
              text: 'Account',
              iconSize: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
