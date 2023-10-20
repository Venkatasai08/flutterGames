import 'dart:math';

import 'package:fluttergames/snake/packagesExport/flutterPackages.dart';
import 'package:table_calendar/table_calendar.dart';

final selectedDateState = StateProvider<DateTime>((ref) => DateTime.now());
final focusedDayState = StateProvider<DateTime>(
    (ref) => DateTime.now().add(const Duration(days: 2)));

class TableCalenderApp extends StatelessWidget {
  const TableCalenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => const TableCalenderWidget());
          },
          child: Consumer(builder: (context, value, ch) {
            DateTime selectedDate = value.watch(selectedDateState);
            return Text("$selectedDate");
          }),
        ),
      ),
    );
  }
}

class TableCalenderWidget extends ConsumerWidget {
  const TableCalenderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var readFocusDate = ref.read(focusedDayState.notifier);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      // backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "date",
              style: TextStyle(color: Colors.white),
            ),
            Consumer(builder: (context, value, ch) {
              DateTime focusedDate = value.watch(focusedDayState);
              debugPrint("callled");
              return TableCalendar(
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  weekdayStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekHeight: 40,
                calendarStyle: const CalendarStyle(
                  markerDecoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  selectedDecoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  outsideTextStyle: TextStyle(color: Colors.transparent),
                  weekendTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                headerStyle: HeaderStyle(
                    headerMargin: const EdgeInsets.all(0),
                    headerPadding: const EdgeInsets.all(0),
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                    leftChevronIcon: Transform.rotate(
                      angle: pi / 2,
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: Colors.grey,
                      ),
                    ),
                    rightChevronIcon: Transform.rotate(
                      angle: -pi / 2,
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: Colors.grey,
                      ),
                    )),
                calendarFormat: CalendarFormat.month,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2050, 3, 14),
                focusedDay: focusedDate,
                onPageChanged: (focusedDay) {
                  debugPrint("days ");
                  value.read(focusedDayState.notifier).state = focusedDay;
                },
                onDaySelected: (selectedDay, focusedDay) {
                  debugPrint("focusDate before $focusedDate $focusedDay");
                  // value.read(selectedDateState.notifier).state = selectedDay;
                  readFocusDate.state = focusedDay;
                  debugPrint("focusDate after $focusedDate $focusedDay");
                },
                rowHeight: 40,
              );
            })
          ],
        ),
      ),
    );
  }
}
