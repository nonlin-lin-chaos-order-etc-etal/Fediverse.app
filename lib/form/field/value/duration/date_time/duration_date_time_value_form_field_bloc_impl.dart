import 'package:fedi/date_time/date_time_extension.dart';
import 'package:fedi/form/field/value/duration/date_time/duration_date_time_value_form_field_bloc.dart';
import 'package:fedi/form/field/value/duration/date_time/duration_date_time_value_form_field_model.dart';
import 'package:fedi/form/field/value/value_form_field_bloc_impl.dart';
import 'package:fedi/form/field/value/value_form_field_validation.dart';
import 'package:flutter/widgets.dart';

class DurationDateTimeValueFormFieldBloc
    extends ValueFormFieldBloc<DurationDateTime>
    implements IDurationDateTimeValueFormFieldBloc {
  @override
  final Duration minDuration;
  @override
  final Duration maxDuration;

  @override
  Duration get currentValueDuration => _calculateDuration(currentValue);

  @override
  Stream<Duration> get currentValueDurationStream => currentValueStream.map(
        (currentValue) => _calculateDuration(currentValue),
      );

  DurationDateTimeValueFormFieldBloc({
    @required DurationDateTime originValue,
    @required this.minDuration,
    @required this.maxDuration,
    @required bool isNullValuePossible,
    @required bool isEnabled,
    List<FormValueFieldValidation<DurationDateTime>> validators = const [],
  }) : super(
          originValue: originValue,
          isNullValuePossible: isNullValuePossible,
          isEnabled: isEnabled,
          validators: validators,
        );

  @override
  void deleteValue() {
    changeCurrentValue(null);
  }

  @override
  void changeCurrentValueDuration(Duration newValue) {
    changeCurrentValue(
      DurationDateTime(
        duration: newValue,
        dateTime: currentValue?.dateTime,
      ),
    );
  }

  Duration _calculateDuration(DurationDateTime currentValue) =>
      currentValue?.duration ?? currentValue?.dateTime?.durationFromNow;
}
