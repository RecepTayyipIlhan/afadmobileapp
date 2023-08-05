import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fbFunProv = Provider(CloudFunctionsService.new);

final _funProv = Provider(
  (_) => FirebaseFunctions.instance,
);

class CloudFunctionsService {
  final Ref _ref;
  const CloudFunctionsService(this._ref);

  FirebaseFunctions get _fun => _ref.read(_funProv);
}
