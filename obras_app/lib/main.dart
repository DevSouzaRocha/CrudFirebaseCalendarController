import 'package:flutter/material.dart';
import 'package:obras_app/Home/home.dart';
import 'package:obras_app/Production/provider/users.dart';
import 'package:obras_app/app_routes.dart';
import 'package:obras_app/Production/views/user_form.dart';
import 'package:obras_app/Production/views/user_list.dart';
import 'package:provider/provider.dart';
import 'package:obras_app/Clients/provider/client.dart';
import 'package:obras_app/Clients/views/client_form.dart';
import 'package:obras_app/Clients/views/client_list.dart';
import 'Calendar/Events.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Clients(),
        ),
      ], child: const App())));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const String _title = 'Nobre Alumínio';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      routes: {
        AppRoutes.HOME: (_) => const MyStatefulWidget(),
        AppRoutes.user_list: (_) => const UserList(),
        AppRoutes.user_form: (_) => const UserForm(),
        AppRoutes.client_form: (_) => const ClientForm(),
        AppRoutes.client_list: (_) => const ClientList(),
        AppRoutes.calendar: (_) => TableEventsExample(),
      },
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    Provider.of<Clients>(
      context,
      listen: false,
    ).loadClients();
    Provider.of<Users>(
      context,
      listen: false,
    ).loadClients();
  }

  @override
  List<Widget> _widgetOptions() {
    return [
      Home(),
      const UserList(),
      const ClientList(),
      const TableEventsExample(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 194, 194, 194),
          alignment: Alignment.center,
          child: _widgetOptions().elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 48, 70, 82),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work),
            label: 'Produção Interna',
            backgroundColor: Color.fromARGB(255, 48, 70, 82),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Produção Externa',
            backgroundColor: Color.fromARGB(255, 48, 70, 82),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
            backgroundColor: Color.fromARGB(255, 48, 70, 82),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
