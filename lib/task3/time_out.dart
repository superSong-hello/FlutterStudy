import 'dart:async';

import 'package:flutter/material.dart';

class TimeOut extends StatefulWidget {
  const TimeOut({super.key});

  @override
  State<TimeOut> createState() => _TimeOutState();
}

class _TimeOutState extends State<TimeOut> {
  String _counttime = '00:00:00';
  int _currentIndex = 0;
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _counttime,
        ),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 设置主轴对齐方式为居中
          children: [
            //PauseCircleOutlineIcon
            _currentIndex == 0
                ? IconButton(
                    onPressed: start, icon: Icon(Icons.play_circle_outlined))
                : IconButton(
                    onPressed:stop,
                    icon: Icon(Icons.pause_circle_outlined)),
            IconButton(onPressed: reset, icon: Icon(Icons.replay_outlined)),
          ],
        ))
      ],
    );
  }

  void start() {
    stopwatch.start();
    ///   Timer.periodic： 这是一个创建定期执行任务的计时器的静态方法。它接受两个参数，第一个参数是Duration，表示执行任务的时间间隔；第二个参数是一个回调函数，表示要定期执行的任务。
    timer = Timer.periodic(Duration(milliseconds: 10), update);
  }

  void update(Timer t) {
    if (stopwatch.isRunning) {
      setState(() {
        _currentIndex = 1;
        stopwatch.start();
        _counttime =
            (stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
                ":" +
                (stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
                ":" +
                ///使用% 1000确保毫秒数在0到999之间，然后除以10以获取十分之一秒的值。clamp(0, 99)确保值在0到99之间，.toStringAsFixed(0)将其转换为字符串，最后使用padLeft(2, "0")确保字符串至少是两位数。
                (stopwatch.elapsed.inMilliseconds % 1000 / 10)
                    .clamp(0, 99)
                    .toStringAsFixed(0)
                    .padLeft(2, "0");
      });
    }
  }

  void stop() {
   setState(() {
     _currentIndex=0;
     timer.cancel();
     stopwatch.stop();
   });
  }

  void reset() {
    setState(() {
      timer.cancel();
      stopwatch.reset();
      _counttime = "00:00:00";
      _currentIndex=0;
      stopwatch.stop();
    });
  }
}
