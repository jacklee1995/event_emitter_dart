# event_emitter

A event tools such as EventEmitter(inspired by NodeJS EventEmitter).

**Author**: **Jack Lee**

**My Blog**: [https://blog.csdn.net/qq_28550263?spm=1011.2415.3001.5343](https://blog.csdn.net/qq_28550263?spm=1011.2415.3001.5343)

**My Email**: [291148484@163.com](mailto:291148484@163.com)

```dart
import 'package:event_emitter/event_emitter.dart';

void main(List<String> args) {
  print('这是一个使用示例：');
  EventEmitter emitter = EventEmitter();

  void listener_1() => print("执行 listener_1");
  void listener_2() => print("执行 listener_2");

  emitter.on("event_1", listener_1); // 添加 listener_1
  emitter.on("event_1", listener_2); // 添加 listener_2

  print(emitter.events); // 输出当前事件
  emitter.emit("event_1", []);

  emitter.off("event_1", listener_1); // 移除 listener_1
  print(emitter.events); // 输出当前事件
  emitter.emit("event_1", []);
}

```

which outputs：

```

{event_1: [Closure: () => void, Closure: () => void]}

执行 listener_1

执行 listener_2

{event_1: [Closure: () => void]}

执行 listener_2

```
