import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kopli/commonWidgets/calendar/custom_calendar.dart';
import 'package:kopli/commonWidgets/myBottom.dart';
import 'package:kopli/commonWidgets/appTheme.dart';
import 'package:kopli/commonWidgets/colorTheme.dart';

class CalendarPopupView extends StatefulWidget {
  const CalendarPopupView(
      {Key key,
      this.initialStartDate,
      this.initialEndDate,
      this.onApplyClick,
      this.onCancelClick,
      this.barrierDismissible = true,
      this.isSingleDate = false,
      this.minimumDate,
      this.maximumDate})
      : super(key: key);

  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final bool isSingleDate;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime, DateTime, int) onApplyClick;

  final Function onCancelClick;
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  DateTime startDate;
  DateTime endDate;
  bool timeMark = true;
  double _hourValue = 12;
  double _minuteValue = 30;
  double _secondValue = 30;

  int hour = 12;
  int minute = 30;
  int second = 30;

  @override
  void initState() {
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 500,
        width: 320,
        decoration: BoxDecoration(
          color: ColorTheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(4, 4),
                blurRadius: 8.0),
          ],
        ),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {},
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.isSingleDate ? "日期" : "From",
                              textAlign: TextAlign.left,
                              style: AppTheme.titleFont,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              startDate != null
                                  ? DateFormat('EEE, dd MMM').format(startDate)
                                  : '/',
                              style: AppTheme.subTitleFont,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 74,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (widget.isSingleDate) {
                              setState(() {
                                timeMark = !timeMark;
                              });
                            }
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.isSingleDate ? "时间" : "To",
                                style: AppTheme.titleFont,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.isSingleDate
                                        ? (hour < 10
                                                ? '0' + hour.toString()
                                                : hour.toString()) +
                                            ' : ' +
                                            minute.toString() +
                                            ' : ' +
                                            second.toString()
                                        : (endDate != null
                                            ? DateFormat('EEE, dd MMM')
                                                .format(endDate)
                                            : '/'),
                                    style: AppTheme.subTitleFont,
                                  ),
                                  widget.isSingleDate
                                      ? SizedBox(
                                          width: 12,
                                        )
                                      : Container(),
                                  widget.isSingleDate
                                      ? FaIcon(
                                          FontAwesomeIcons.chevronDown,
                                          size: 12,
                                          color: ColorTheme.mainBlack,
                                        )
                                      : Container()
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    height: 1,
                  ),
                  CustomCalendarView(
                      minimumDate: widget.minimumDate,
                      maximumDate: widget.maximumDate,
                      initialEndDate: widget.initialEndDate,
                      initialStartDate: widget.initialStartDate,
                      isSingleDate: widget.isSingleDate,
                      startEndDateChange:
                          (DateTime startDateData, DateTime endDateData) {
                        setState(() {
                          startDate = startDateData;
                          endDate = endDateData;
                        });
                      },
                      monthConfirm: (DateTime _month) {
                        widget.onApplyClick(null, null, _month, 0);
                        Navigator.pop(context);
                      }),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyBottom(
                            title: "取消",
                            onPress: () {
                              Navigator.pop(context);
                            },
                          ),
                          MyBottom(
                            title: "确认",
                            type: "confirm",
                            onPress: () {
                              try {
                                if (widget.isSingleDate) {
                                  changeDate();
                                }

                                if (endDate == null) {
                                  widget.onApplyClick(startDate, null, null, 1);
                                } else {
                                  widget.onApplyClick(
                                      startDate, endDate, null, 2);
                                }

                                Navigator.pop(context);
                              } catch (_) {}
                            },
                          ),
                        ],
                      )),
                ],
              ),
              Positioned(
                  right: 30,
                  top: 65,
                  child: Container(
                      decoration: BoxDecoration(
                        color: ColorTheme.mainBlack.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: timeMark
                          ? Container()
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: Slider(
                                      min: 0,
                                      max: 24,
                                      activeColor: ColorTheme.mainGreen,
                                      inactiveColor: ColorTheme.grey,
                                      value: _hourValue,
                                      onChanged: (v) {
                                        setState(() {
                                          _hourValue = v;
                                          hour = v.toInt();
                                        });
                                      },
                                    )),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: Slider(
                                      min: 0,
                                      max: 60,
                                      activeColor: ColorTheme.mainGreen,
                                      inactiveColor: ColorTheme.grey,
                                      value: _minuteValue,
                                      onChanged: (v) {
                                        setState(() {
                                          _minuteValue = v;
                                          minute = v.toInt();
                                        });
                                      },
                                    )),
                                RotatedBox(
                                    quarterTurns: 1,
                                    child: Slider(
                                      min: 0,
                                      max: 60,
                                      activeColor: ColorTheme.mainGreen,
                                      inactiveColor: ColorTheme.grey,
                                      value: _secondValue,
                                      onChanged: (v) {
                                        setState(() {
                                          _secondValue = v;
                                          second = v.toInt();
                                        });
                                      },
                                    ))
                              ],
                            )))
            ])),
      ),
    );
  }

  void changeDate() {
    String _date = DateFormat('yyyy-MM-dd').format(startDate);
    if (hour <= 9) {
      _date = _date +
          ' 0' +
          hour.toString() +
          ':' +
          minute.toString() +
          ':' +
          second.toString();
    } else {
      _date = _date +
          ' ' +
          hour.toString() +
          ':' +
          minute.toString() +
          ':' +
          second.toString();
    }
    setState(() {
      startDate = DateTime.parse(_date);
    });
  }
}
