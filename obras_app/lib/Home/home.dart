// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:obras_app/Clients/models/client.dart';
import 'package:obras_app/Clients/provider/client.dart';
import 'package:obras_app/Home/Pie.dart';
import 'package:obras_app/Production/models/user.dart';
import 'package:obras_app/Production/provider/users.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Client> events = [];
  List<User> events2 = [];

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
    events2 = Provider.of<Users>(
      context,
      listen: false,
    ).all;
    events = Provider.of<Clients>(
      context,
      listen: false,
    ).all;
  }

  List<Data> convertEventsInData() {
    List<Data> dataEvents = [];

    dataEvents.clear();

    dataEvents.add(Data(
        name: "Suprimentos",
        percent:
            count() == 0 ? 0 : (count() / events.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 250, 90, 90)));
    dataEvents.add(Data(
        name: "Fabricação",
        percent: count1() == 0
            ? 0
            : (count1() / events.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 255, 157, 100)));
    dataEvents.add(Data(
        name: "Entrega",
        percent: count2() == 0
            ? 0
            : (count2() / events.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 255, 243, 139)));
    dataEvents.add(Data(
        name: "Finalizados",
        percent: count3() == 0
            ? 0
            : (count3() / events.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 121, 224, 124)));

    return dataEvents;
  }

  List<Data> convertEventsInData2() {
    List<Data> dataEvents = [];

    dataEvents.clear();

    dataEvents.add(Data(
        name: "Suprimentos",
        percent: count4() == 0
            ? 0
            : (count4() / events2.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 250, 90, 90)));
    dataEvents.add(Data(
        name: "Fabricação",
        percent: count5() == 0
            ? 0
            : (count5() / events2.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 255, 157, 100)));
    dataEvents.add(Data(
        name: "Entrega",
        percent: count6() == 0
            ? 0
            : (count6() / events2.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 255, 243, 139)));
    dataEvents.add(Data(
        name: "Finalizados",
        percent: count7() == 0
            ? 0
            : (count7() / events2.length * 100).roundToDouble(),
        color: const Color.fromARGB(255, 121, 224, 124)));

    return dataEvents;
  }

  count() {
    int supri = 0;
    for (int i = 0; i < events.length; i++) {
      if (events[i].Estatus == 'suprimentos') {
        supri++;
      }
    }
    return supri;
  }

  count1() {
    int supri = 0;
    for (int i = 0; i < events.length; i++) {
      if (events[i].Estatus == 'fabricacao') {
        supri++;
      }
    }
    return supri;
  }

  count2() {
    int supri = 0;
    for (int i = 0; i < events.length; i++) {
      if (events[i].Estatus == 'entrega') {
        supri++;
      }
    }
    return supri;
  }

  count3() {
    int supri = 0;
    for (int i = 0; i < events.length; i++) {
      if (events[i].Estatus == 'finalizado') {
        supri++;
      }
    }
    return supri;
  }

  count4() {
    int supri = 0;
    for (int i = 0; i < events2.length; i++) {
      if (events2[i].Estatus == 'suprimentos') {
        supri++;
      }
    }
    return supri;
  }

  count5() {
    int supri = 0;
    for (int i = 0; i < events2.length; i++) {
      if (events2[i].Estatus == 'fabricacao') {
        supri++;
      }
    }
    return supri;
  }

  count6() {
    int supri = 0;
    for (int i = 0; i < events2.length; i++) {
      if (events2[i].Estatus == 'entrega') {
        supri++;
      }
    }
    return supri;
  }

  count7() {
    int supri = 0;
    for (int i = 0; i < events2.length; i++) {
      if (events2[i].Estatus == 'finalizado') {
        supri++;
      }
    }
    return supri;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home',
              style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25.0)),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 48, 70, 82),
        ),
        body: Container(
          color: const Color.fromARGB(255, 194, 194, 194),
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 10,
                    crossAxisSpacing: 10,
                    children: const <Widget>[
                      Card(
                        shadowColor: Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: Color.fromARGB(255, 162, 178, 187),
                        child: Center(
                          child: Text(
                            'Obras Internas',
                            style: TextStyle(
                                fontStyle: FontStyle.normal, fontSize: 20.0),
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: Color.fromARGB(255, 162, 178, 187),
                        child: Center(
                            child: Text(
                          'Obras Externas',
                          style: TextStyle(
                              fontStyle: FontStyle.normal, fontSize: 20.0),
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: 6,
                    crossAxisSpacing: 10,
                    children: <Widget>[
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 250, 90, 90),
                        child: Center(
                            child: Text('Aguardando Suprimentos: ${count4()}')),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 255, 157, 100),
                        child: Center(
                            child: Text('Aguardando Fabricação: ${count5()}')),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 250, 90, 90),
                        child: Center(
                            child: Text("Aguardando Suprimentos: ${count()}")),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 255, 157, 100),
                        child: Center(
                            child: Text('Aguardando Fabricação: ${count1()}')),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 255, 243, 139),
                        child: Center(
                            child: Text('Aguardando Entrega: ${count6()}')),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 121, 224, 124),
                        child: Center(child: Text('Finalizadas: ${count7()}')),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 255, 243, 139),
                        child: Center(
                            child: Text('Aguardando Instalação: ${count2()}')),
                      ),
                      Card(
                        shadowColor: const Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: const Color.fromARGB(255, 121, 224, 124),
                        child: Center(child: Text('Finalizadas: ${count3()}')),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    crossAxisSpacing: 10,
                    children: <Widget>[
                      Card(
                        shadowColor: Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: Color.fromARGB(255, 162, 178, 187),
                        child: PieChart(PieChartData(
                            borderData: FlBorderData(show: false),
                            centerSpaceRadius: 100,
                            sections: getSections(convertEventsInData2()))),
                      ),
                      Card(
                        shadowColor: Color.fromARGB(255, 48, 70, 82),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromARGB(255, 48, 70, 82),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        color: Color.fromARGB(255, 162, 178, 187),
                        child: PieChart(PieChartData(
                            borderData: FlBorderData(show: false),
                            centerSpaceRadius: 100,
                            sections: getSections(convertEventsInData()))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
