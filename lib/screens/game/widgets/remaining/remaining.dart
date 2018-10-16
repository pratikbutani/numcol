// Copyright (C) 2018 Alberto Varela Sánchez <alberto@berriart.com>
// Use of this source code is governed by the version 3 of the
// GNU General Public License that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'remaining_counter.dart';
import '../../../../core/index.dart';
import '../../../../services/index.dart';

class RemainingWidget extends StatefulWidget {
  RemainingWidget({Key key, @required this.timer}) : super(key: key);

  final Timer timer;

  @override
  _RemainingWidgetState createState() => _RemainingWidgetState();
}

class _RemainingWidgetState extends State<RemainingWidget> with TickerProviderStateMixin {
  void _setState() {
    setState(() => null);
  }

  @override
  void initState() {
    super.initState();
    widget.timer.start(this);
    widget.timer.controller.addListener(_setState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(Translations.of(context).text('time')),
        RemainingCounter(
          animation: StepTween(
            begin: widget.timer.maxTimeInMilliseconds.round(),
            end: 0,
          ).animate(widget.timer.controller.value),
        ),
      ]
    );
  }

  @override
  void dispose() {
    widget.timer.controller.value?.dispose();
    widget.timer.controller.removeListener(_setState);
    super.dispose();
  }
}