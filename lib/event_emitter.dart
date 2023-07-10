/// 用于发布订阅模式的事件发布器
class EventEmitter {
  final Map<String, List<Function>> _events = {};
  int _maxListeners = 10;

  get events {
    return _events;
  }

  /// 向事件添加侦听器
  EventEmitter addListener(String event, Function listener) {
    // 如果事件尚不存在，为其创建一个空列表
    if (!_events.containsKey(event)) {
      _events[event] = [];
    }

    // 将监听器添加到事件列表中
    _events[event]?.add(listener);

    if (_events[event]?.length == _maxListeners) {
      throw 'Max listeners exceeded';
    }
    return this;
  }

  /// addListener 的同名方法：将监听器添加到事件列表中
  EventEmitter on(String event, Function listener) {
    return addListener(event, listener);
  }

  /// 从事件中删除侦听器
  EventEmitter removeListener(String event, Function listener) {
    // 如果事件存在，请从列表中删除侦听器
    if (_events.containsKey(event)) {
      _events[event]?.remove(listener);
    }

    return this;
  }

  /// removeListener 的同名方法：从事件中删除侦听器
  EventEmitter off(String event, Function listener) {
    return removeListener(event, listener);
  }

  /// 从事件中删除所有侦听器
  EventEmitter removeAllListeners(String event) {
    // If the event exists, remove its list of listeners
    if (_events.containsKey(event)) {
      _events.remove(event);
    }

    return this;
  }

  /// 添加一次性的侦听器
  _onceListener(String event, Function listener) {
    removeListener(event, _onceListener);
    return listener();
  }

  /// 为名为 event 的事件添加 一次性 的 listener 函数
  EventEmitter once(String event, Function listener) {
    // 创建一个新的侦听器，该侦听器在被调用后移除自身

    // 将包装侦听器添加到事件列表的末尾
    addListener(event, _onceListener);

    return this;
  }

  /// 获取指定事件的监听器数量
  int listenerCount(String event) {
    // 如果事件存在，则返回其侦听器列表的长度
    if (_events.containsKey(event)) {
      return _events[event]!.length;
    }
    return 0;
  }

  /// 获取指定事件的监听器数组
  List<Function>? getEventListeners(String event) {
    // 如果事件存在，则返回其侦听器列表
    if (_events.containsKey(event)) {
      return _events[event];
    }
    // 否则，返回一个空列表
    return [];
  }

  /// 获取事件侦听器数组
  List<Function>? listeners(String event) {
    return getEventListeners(event);
  }

  /// 获取事件侦听器数组的副本
  List<Function> rawListeners(String event) {
    // 如果事件存在，则返回其侦听器列表的副本
    if (_events.containsKey(event)) {
      return List<Function>.from(_events[event]!);
    }
    // 否则，返回一个空列表
    return [];
  }

  /// 设置事件的最大侦听器数量
  EventEmitter setMaxListeners(int maxListeners) {
    _maxListeners = maxListeners;
    return this;
  }

  /// 获取事件的最大侦听器数量
  int getMaxListeners() {
    return _maxListeners;
  }

  /// 用给定的参数发出事件
  EventEmitter emit(String event, [List<dynamic> args = const []]) {
    // 如果事件存在，用给定的参数调用它的所有侦听器
    if (_events.containsKey(event)) {
      for (Function listener in _events[event]!) {
        listener();
      }
    }
    return this;
  }

  /// 将侦听器添加到事件侦听器列表的开头
  EventEmitter prependListener(String event, Function listener) {
    // 如果事件尚不存在，为其创建一个空列表
    if (!_events.containsKey(event)) {
      _events[event] = [];
    }

    if (_events[event]?.length == _maxListeners) {
      print('Max listeners exceeded');
    }

    // 将侦听器添加到事件列表的开头
    _events[event]?.insert(0, listener);

    return this;
  }

  /// 将一次性侦听器添加到事件侦听器列表的开头
  EventEmitter prependOnceListener(String event, Function listener) {
    // 创建一个新的侦听器，该侦听器在被调用后移除自身

    // 将包装侦听器添加到事件列表的开头
    prependListener(event, _onceListener);
    return this;
  }

  /// 获取所有具有侦听器的事件的名称
  List<String> eventNames() {
    // 返回 _events 中键的副本
    return List<String>.from(_events.keys);
  }
}
