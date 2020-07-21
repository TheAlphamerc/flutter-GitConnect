import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent extends Equatable {}

class IndexSelected extends NavigationEvent {
  final int index;
  IndexSelected(this.index);

  @override
  List<Object> get props => ["Select page index: $index"];
}
