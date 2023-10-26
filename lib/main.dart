import 'package:joiner_1/pages/cra/account/cra_account_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'index.dart';
import 'pages/cra/car/cra_car_widget.dart';
import 'pages/cra/earnings/earnings_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: appState,
      ),
      ChangeNotifierProvider(
        create: (context) => AppStateNotifier.instance,
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;
  late FFAppState _appState;
  late AppStateNotifier _appStateNotifier;

  @override
  void initState() {
    super.initState();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

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
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: GoRouter(
        initialLocation: '/login',
        debugLogDiagnostics: true,
        refreshListenable: _appStateNotifier,
        errorBuilder: (context, state) => LoginPageWidget(),
        routes: _appStateNotifier.routes
            .map((r) => r.toRoute(_appStateNotifier))
            .toList(),
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
      'VirtualLobby': LobbiesWidget(),
      'CarRentals': RentalsWidget(),
      'Friends': FriendsWidget(),
      'Account': AccountWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        color: FlutterFlowTheme.of(context).secondaryText,
        activeColor: FlutterFlowTheme.of(context).primary,
        tabBackgroundColor: Color(0x00000000),
        tabBorderRadius: 0.0,
        tabMargin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        gap: 0.0,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        duration: Duration(milliseconds: 500),
        haptic: false,
        tabs: [
          GButton(
            icon: Icons.meeting_room_rounded,
            text: 'Lobby',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.directions_car,
            text: 'Rentals',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.people_alt_outlined,
            text: 'Friends',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.person_outline,
            text: 'Account',
            iconSize: 24.0,
          )
        ],
      ),
    );
  }

  Widget craDashboard() {
    final tabs = {
      'Earnings': EarningsWidget(),
      'Cars': CraCarWidget(),
      'Account': CraAccountWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      bottomNavigationBar: GNav(
        selectedIndex: currentIndex,
        onTabChange: (i) => setState(() {
          _currentPage = null;
          _currentPageName = tabs.keys.toList()[i];
        }),
        backgroundColor: Colors.white,
        color: FlutterFlowTheme.of(context).secondaryText,
        activeColor: FlutterFlowTheme.of(context).primary,
        tabBackgroundColor: Color(0x00000000),
        tabBorderRadius: 0.0,
        tabMargin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        gap: 0.0,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        duration: Duration(milliseconds: 500),
        haptic: false,
        tabs: [
          GButton(
            icon: Icons.attach_money,
            text: 'Earnings',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.directions_car,
            text: 'Cars',
            iconSize: 24.0,
          ),
          GButton(
            icon: Icons.person,
            text: 'Account',
            iconSize: 24.0,
          ),
        ],
      ),
    );
  }
}
