import 'package:fedi/app/settings/edit_settings_bloc.dart';
import 'package:fedi/app/settings/settings_model.dart';

abstract class IEditInstanceSettingsBloc<T extends ISettings>
    implements IEditSettingsBloc<T> {}
