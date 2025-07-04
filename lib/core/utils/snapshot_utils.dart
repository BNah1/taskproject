import 'package:flutter/cupertino.dart';
import 'package:taskproject/core/widget/loader_widget.dart';

Widget checkSnapShot<T>(AsyncSnapshot<List<T>> snapshot, Widget Function(List<T>) onData){
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Loader();
  } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return const Center(child: Text('Empty'));
  }
  return onData(snapshot.data!);
}

Widget checkSnapShotSingleObject<T>(AsyncSnapshot<T> snapshot, Widget Function(T) onData){
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Loader();
  } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
  } else if (!snapshot.hasData) {
    return const Center(child: Text('Empty'));
  }
  return onData(snapshot.data as T);
}