// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AdminMapState {
  GoogleMapController? get mapController => throw _privateConstructorUsedError;
  LatLng? get selectedLocation => throw _privateConstructorUsedError;
  Set<Marker> get mapMarkers => throw _privateConstructorUsedError;
  bool get show => throw _privateConstructorUsedError;
  int get selectedRowIndex => throw _privateConstructorUsedError;
  List<AppUser> get users => throw _privateConstructorUsedError;
  List<HelpMessage> get messages => throw _privateConstructorUsedError;
  int get sortColumnIndex =>
      throw _privateConstructorUsedError; // Initialize with the index of the "Tür" column.
  bool get sortAscending => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AdminMapStateCopyWith<AdminMapState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminMapStateCopyWith<$Res> {
  factory $AdminMapStateCopyWith(
          AdminMapState value, $Res Function(AdminMapState) then) =
      _$AdminMapStateCopyWithImpl<$Res, AdminMapState>;
  @useResult
  $Res call(
      {GoogleMapController? mapController,
      LatLng? selectedLocation,
      Set<Marker> mapMarkers,
      bool show,
      int selectedRowIndex,
      List<AppUser> users,
      List<HelpMessage> messages,
      int sortColumnIndex,
      bool sortAscending});
}

/// @nodoc
class _$AdminMapStateCopyWithImpl<$Res, $Val extends AdminMapState>
    implements $AdminMapStateCopyWith<$Res> {
  _$AdminMapStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapController = freezed,
    Object? selectedLocation = freezed,
    Object? mapMarkers = null,
    Object? show = null,
    Object? selectedRowIndex = null,
    Object? users = null,
    Object? messages = null,
    Object? sortColumnIndex = null,
    Object? sortAscending = null,
  }) {
    return _then(_value.copyWith(
      mapController: freezed == mapController
          ? _value.mapController
          : mapController // ignore: cast_nullable_to_non_nullable
              as GoogleMapController?,
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      mapMarkers: null == mapMarkers
          ? _value.mapMarkers
          : mapMarkers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedRowIndex: null == selectedRowIndex
          ? _value.selectedRowIndex
          : selectedRowIndex // ignore: cast_nullable_to_non_nullable
              as int,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<AppUser>,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<HelpMessage>,
      sortColumnIndex: null == sortColumnIndex
          ? _value.sortColumnIndex
          : sortColumnIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sortAscending: null == sortAscending
          ? _value.sortAscending
          : sortAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AdminMapStateCopyWith<$Res>
    implements $AdminMapStateCopyWith<$Res> {
  factory _$$_AdminMapStateCopyWith(
          _$_AdminMapState value, $Res Function(_$_AdminMapState) then) =
      __$$_AdminMapStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GoogleMapController? mapController,
      LatLng? selectedLocation,
      Set<Marker> mapMarkers,
      bool show,
      int selectedRowIndex,
      List<AppUser> users,
      List<HelpMessage> messages,
      int sortColumnIndex,
      bool sortAscending});
}

/// @nodoc
class __$$_AdminMapStateCopyWithImpl<$Res>
    extends _$AdminMapStateCopyWithImpl<$Res, _$_AdminMapState>
    implements _$$_AdminMapStateCopyWith<$Res> {
  __$$_AdminMapStateCopyWithImpl(
      _$_AdminMapState _value, $Res Function(_$_AdminMapState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mapController = freezed,
    Object? selectedLocation = freezed,
    Object? mapMarkers = null,
    Object? show = null,
    Object? selectedRowIndex = null,
    Object? users = null,
    Object? messages = null,
    Object? sortColumnIndex = null,
    Object? sortAscending = null,
  }) {
    return _then(_$_AdminMapState(
      mapController: freezed == mapController
          ? _value.mapController
          : mapController // ignore: cast_nullable_to_non_nullable
              as GoogleMapController?,
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      mapMarkers: null == mapMarkers
          ? _value._mapMarkers
          : mapMarkers // ignore: cast_nullable_to_non_nullable
              as Set<Marker>,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedRowIndex: null == selectedRowIndex
          ? _value.selectedRowIndex
          : selectedRowIndex // ignore: cast_nullable_to_non_nullable
              as int,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<AppUser>,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<HelpMessage>,
      sortColumnIndex: null == sortColumnIndex
          ? _value.sortColumnIndex
          : sortColumnIndex // ignore: cast_nullable_to_non_nullable
              as int,
      sortAscending: null == sortAscending
          ? _value.sortAscending
          : sortAscending // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AdminMapState extends _AdminMapState {
  const _$_AdminMapState(
      {this.mapController,
      this.selectedLocation,
      required final Set<Marker> mapMarkers,
      required this.show,
      required this.selectedRowIndex,
      required final List<AppUser> users,
      required final List<HelpMessage> messages,
      required this.sortColumnIndex,
      required this.sortAscending})
      : _mapMarkers = mapMarkers,
        _users = users,
        _messages = messages,
        super._();

  @override
  final GoogleMapController? mapController;
  @override
  final LatLng? selectedLocation;
  final Set<Marker> _mapMarkers;
  @override
  Set<Marker> get mapMarkers {
    if (_mapMarkers is EqualUnmodifiableSetView) return _mapMarkers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_mapMarkers);
  }

  @override
  final bool show;
  @override
  final int selectedRowIndex;
  final List<AppUser> _users;
  @override
  List<AppUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final List<HelpMessage> _messages;
  @override
  List<HelpMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final int sortColumnIndex;
// Initialize with the index of the "Tür" column.
  @override
  final bool sortAscending;

  @override
  String toString() {
    return 'AdminMapState(mapController: $mapController, selectedLocation: $selectedLocation, mapMarkers: $mapMarkers, show: $show, selectedRowIndex: $selectedRowIndex, users: $users, messages: $messages, sortColumnIndex: $sortColumnIndex, sortAscending: $sortAscending)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AdminMapState &&
            (identical(other.mapController, mapController) ||
                other.mapController == mapController) &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation) &&
            const DeepCollectionEquality()
                .equals(other._mapMarkers, _mapMarkers) &&
            (identical(other.show, show) || other.show == show) &&
            (identical(other.selectedRowIndex, selectedRowIndex) ||
                other.selectedRowIndex == selectedRowIndex) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.sortColumnIndex, sortColumnIndex) ||
                other.sortColumnIndex == sortColumnIndex) &&
            (identical(other.sortAscending, sortAscending) ||
                other.sortAscending == sortAscending));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      mapController,
      selectedLocation,
      const DeepCollectionEquality().hash(_mapMarkers),
      show,
      selectedRowIndex,
      const DeepCollectionEquality().hash(_users),
      const DeepCollectionEquality().hash(_messages),
      sortColumnIndex,
      sortAscending);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AdminMapStateCopyWith<_$_AdminMapState> get copyWith =>
      __$$_AdminMapStateCopyWithImpl<_$_AdminMapState>(this, _$identity);
}

abstract class _AdminMapState extends AdminMapState {
  const factory _AdminMapState(
      {final GoogleMapController? mapController,
      final LatLng? selectedLocation,
      required final Set<Marker> mapMarkers,
      required final bool show,
      required final int selectedRowIndex,
      required final List<AppUser> users,
      required final List<HelpMessage> messages,
      required final int sortColumnIndex,
      required final bool sortAscending}) = _$_AdminMapState;
  const _AdminMapState._() : super._();

  @override
  GoogleMapController? get mapController;
  @override
  LatLng? get selectedLocation;
  @override
  Set<Marker> get mapMarkers;
  @override
  bool get show;
  @override
  int get selectedRowIndex;
  @override
  List<AppUser> get users;
  @override
  List<HelpMessage> get messages;
  @override
  int get sortColumnIndex;
  @override // Initialize with the index of the "Tür" column.
  bool get sortAscending;
  @override
  @JsonKey(ignore: true)
  _$$_AdminMapStateCopyWith<_$_AdminMapState> get copyWith =>
      throw _privateConstructorUsedError;
}
