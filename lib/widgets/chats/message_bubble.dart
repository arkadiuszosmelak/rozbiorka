import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.username,
    this.timestamp,
    this.previousTimestamp,
    this.isMe, {
    this.key,
  });

  final Key key;
  final String message;
  final String username;
  final int timestamp;
  final int previousTimestamp;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    // Intl.defaultLocale = 'pl';
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime previousTime =
        DateTime.fromMillisecondsSinceEpoch(previousTimestamp);
    DateTime timeNow = DateTime.now();
    var formats = DateFormat();

    var visibleMessageDate = false;

    // wyswietla date nad wiadomoscia tylko gdy poprzednia byla ponad 15 min wczesniej
    if (time.isAfter(previousTime.add(Duration(minutes: 15)))) {
      visibleMessageDate = true;
    }

    // dekorator daty
    if (time.year == timeNow.year &&
        time.month == timeNow.month &&
        time.day == timeNow.day) {
      formats = DateFormat("HH:mm");
    } else if (time.isAfter(timeNow.subtract(Duration(days: 7)))) {
      formats = DateFormat("EEEE • HH:mm");
    } else if (time.year == timeNow.year) {
      formats = DateFormat("EE d MMM • HH:mm");
    } else {
      formats = DateFormat("EE d MMM yyyy • HH:mm");
    }
    var dateString = formats.format(time);

    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        visibleMessageDate
            ? Center(
                child: Text(dateString),
              )
            : const SizedBox(),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: isMe
                          ? Theme.of(context).accentTextTheme.headline1.color
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
