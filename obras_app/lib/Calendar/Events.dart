import 'package:flutter/material.dart';
import 'package:obras_app/Clients/models/client.dart';
import 'package:obras_app/Production/models/user.dart';
import 'package:obras_app/Production/provider/users.dart';
import 'package:obras_app/pdf.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'CalendarScreen/EventsConstructor.dart';
import 'package:obras_app/Clients/provider/client.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({Key? key}) : super(key: key);

  @override
  TableState createState() => TableState();
}

class TableState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void dispose() {
    selectedEvents.dispose();
    super.dispose();
  }

  List<Client> events = [];
  List<User> events2 = [];
  List<User> events3 = [];

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

    _selectedDay = _focusedDay;
    selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    events2 = Provider.of<Users>(
      context,
      listen: false,
    ).all;

    events3 = Provider.of<Users>(
      context,
      listen: false,
    ).all;

    events = Provider.of<Clients>(
      context,
      listen: false,
    ).all;
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> eventsDate = [];

    eventsDate.clear();
    for (int i = 0; i < events.length; i++) {
      String dayFormatted =
          "${day.toString().split(" ")[0].split("-")[2]}/${day.toString().split(" ")[0].split("-")[1]}/${day.toString().split(" ")[0].split("-")[0]}";

      if (events[i].Data_Entrega.replaceAll(" ", "") == dayFormatted &&
          events[i].Estatus != 'finalizado') {
        eventsDate.add(
            Event(events[i].Ide, events[i].Data_Entrega, events[i].Estatus));
      }
    }
    for (int i = 0; i < events2.length; i++) {
      String dayFormatted =
          "${day.toString().split(" ")[0].split("-")[2]}/${day.toString().split(" ")[0].split("-")[1]}/${day.toString().split(" ")[0].split("-")[0]}";

      if (events2[i].Previsao_Instalacao.replaceAll(" ", "") == dayFormatted &&
          events2[i].Estatus != 'finalizado') {
        eventsDate.add(Event(events2[i].Id_Obra, events2[i].Previsao_Instalacao,
            events2[i].Estatus));
      }
    }
    for (int i = 0; i < events3.length; i++) {
      String dayFormatted =
          "${day.toString().split(" ")[0].split("-")[2]}/${day.toString().split(" ")[0].split("-")[1]}/${day.toString().split(" ")[0].split("-")[0]}";

      if (events3[i].Previsao_Producao.replaceAll(" ", "") == dayFormatted &&
          events[i].Estatus != 'finalizado') {
        eventsDate.add(Event(events3[i].Id_Obra, events3[i].Previsao_Producao,
            events3[i].Estatus));
      }
    }

    return eventsDate;
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
      });

      selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos',
            style: TextStyle(fontStyle: FontStyle.normal, fontSize: 25.0)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              Pdf().generatePdf(selectedEvents);
            },
          )
        ],
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 48, 70, 82),
      ),
      body: Container(
        margin: const EdgeInsets.all(4.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 162, 178, 187),
              Color.fromARGB(255, 162, 178, 187),
            ])),
        child: Column(
          children: [
            TableCalendar<Event>(
              locale: 'PT_BR',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  fontSize: 20,
                ),
                titleCentered: true,
              ),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 48, 70, 82),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 92, 119, 134),
                  shape: BoxShape.circle,
                ),
                rangeStartDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 92, 119, 134),
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 92, 119, 134),
                  shape: BoxShape.circle,
                ),
                rangeHighlightColor: Color.fromARGB(255, 210, 217, 221),
                canMarkersOverflow: true,
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      //Chamar user com base em Id_obra
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 210, 217, 221),
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () {
                            var x = value[index];
                            print(x);
                          },
                          title: Center(child: Text('${value[index]}')),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
