import 'package:abstraction_unit_test_provider/services/api.dart';
import 'package:abstraction_unit_test_provider/services/localstorage_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  Provider.value(value: LocalStorageService()),
  Provider.value(
    value: Api(),
  )
];
