import 'package:flutter/material.dart';

String makeTextReturn() {
  return 'Returnable';
}

void test() {
  print(makeTextReturn());
  print(makeTextReturn().substring(0, 5) + ' some');
  List<int> numbers = [1, 2];
}

class Timer {
  int startTime;

  Timer(this.startTime);

  @override
  bool operator ==(covariant Timer other) => other.startTime == startTime;

  factory Timer.newTimer() {
    return Timer(0);
  }

  @override
  int get hashCode => startTime.hashCode;

  void doubleTime() => startTime *= 2;

  Future<int> futureOfTimer(int next) {
    return Future.delayed(const Duration(seconds: 3), () => next * 2);
  }

  void test() async {
    final res = await futureOfTimer(50);
    print(res);
  }

  Stream<int> getTime() {
    //return Stream.value(startTime);
    return Stream.periodic(const Duration(seconds: 1), (value) {
      return startTime;
    });
  }

  void test1() async {
    await for (final value in getTime()) {
      print(value);
    }
    print('Stream finished work');
  }

  Iterable<int> getNextThreeTicks() sync* {
    yield 1;
    yield 2;
    yield 5;
  }
}

class Parents {
  final String mam;
  final String dad;
  Parents(this.dad, this.mam);
}

class P<M, D> {
  final M mam;
  final D dad;
  P(this.dad, this.mam);
}

extension Tick on Timer {
  void tick() {
    startTime++;
  }
}

void main() {
  test();
  final timer = Timer(12);
  timer.tick();
  print(timer.startTime);
  timer.doubleTime();
  print(timer.startTime);
  timer.test();
  //timer.test1();

  final par = P("Oleg", "Inna");
  final par2 = P(46, 41);
  print(par.dad + ' ' + par.mam);
  print(par2.dad.toString() + ' ' + par2.mam.toString());
}

class ListHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
