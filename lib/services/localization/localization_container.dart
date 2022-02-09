import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/services/localization/localization_cubit.dart';

class LocalizationContainer extends StatelessWidget {
  final Widget child;
  const LocalizationContainer({ Key key, @required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<CurrentLocaleCubit>(
    create: (context) => CurrentLocaleCubit(),
    child: this.child,
  );
}