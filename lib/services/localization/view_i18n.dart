import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/services/localization/localization_cubit.dart';

class ViewI18N {
  String _language;

  ViewI18N(BuildContext context) {
    this._language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String localize(Map<String, String> translations) {
    assert(_language != null, 'No language defined');
    assert(translations != null, 'Missing translations');
    assert(translations.containsKey(_language), 'Missing transalation for $_language language');

    return translations[_language];
  }
}