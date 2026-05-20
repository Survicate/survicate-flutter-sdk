import 'dart:convert';

import 'package:flutter/material.dart' hide ThemeMode;
import 'package:survicate_sdk/survicate_sdk.dart';
import 'package:survicate_sdk/user_trait.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

const int _logLimit = 50;

class _MyAppState extends State<MyApp> {
  // Workspace
  final _workspaceKeyController = TextEditingController();
  bool _sdkInitialized = false;

  // Events
  final _eventNameController = TextEditingController();
  final _propKeyController = TextEditingController();
  final _propValueController = TextEditingController();
  final Map<String, String> _eventProps = {};

  // User traits
  final _traitKeyController = TextEditingController();
  final _traitValueController = TextEditingController();
  final List<_TraitEntry> _traits = [];

  // Screens
  final _screenNameController = TextEditingController();

  // Response attributes
  final _attrNameController = TextEditingController();
  final _attrValueController = TextEditingController();
  final _attrProviderController = TextEditingController();
  final List<_AttrEntry> _responseAttrs = [];

  // Locale
  final _localeController = TextEditingController();

  // Log
  final List<_LogEntry> _log = [];
  final Set<int> _expandedIds = {};
  bool _logVisible = true;
  int _nextId = 0;

  SurvicateEventListener? _listener;

  @override
  void dispose() {
    if (_listener != null) {
      SurvicateSdk.removeSurvicateEventListener(_listener!);
    }
    _workspaceKeyController.dispose();
    _eventNameController.dispose();
    _propKeyController.dispose();
    _propValueController.dispose();
    _traitKeyController.dispose();
    _traitValueController.dispose();
    _screenNameController.dispose();
    _attrNameController.dispose();
    _attrValueController.dispose();
    _attrProviderController.dispose();
    _localeController.dispose();
    super.dispose();
  }

  int _id() => ++_nextId;

  void _appendLog(String type, Object? payload) {
    setState(() {
      _log.insert(0, _LogEntry(_id(), DateTime.now(), type, payload));
      if (_log.length > _logLimit) {
        _log.removeRange(_logLimit, _log.length);
      }
    });
  }

  void _toggleExpanded(int id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  void _initializeSdk() {
    final key = _workspaceKeyController.text;
    SurvicateSdk.setWorkspaceKey(key);
    SurvicateSdk.initializeSdk();
    final listener = SurvicateEventListener(
      onSurveyDisplayed: (event) => _appendLog(
        'onSurveyDisplayed',
        {'surveyId': event.surveyId},
      ),
      onQuestionAnswered: (event) => _appendLog('onQuestionAnswered', {
        'surveyId': event.surveyId,
        'surveyName': event.surveyName,
        'visitorUuid': event.visitorUuid,
        'responseUuid': event.responseUuid,
        'questionId': event.questionId,
        'question': event.question,
        'answer': {
          'type': event.answer.type,
          'id': event.answer.id,
          'ids': event.answer.ids,
          'value': event.answer.value,
        },
        'panelAnswerUrl': event.panelAnswerUrl,
      }),
      onSurveyClosed: (event) => _appendLog(
        'onSurveyClosed',
        {'surveyId': event.surveyId},
      ),
      onSurveyCompleted: (event) => _appendLog(
        'onSurveyCompleted',
        {'surveyId': event.surveyId},
      ),
    );
    SurvicateSdk.addSurvicateEventListener(listener);
    setState(() {
      _listener = listener;
      _sdkInitialized = true;
    });
    _appendLog('→ initializeSdk', {'workspaceKey': key});
  }

  void _addEventProp() {
    final key = _propKeyController.text;
    if (key.isEmpty) return;
    setState(() {
      _eventProps[key] = _propValueController.text;
      _propKeyController.clear();
      _propValueController.clear();
    });
  }

  void _removeEventProp(String key) {
    setState(() => _eventProps.remove(key));
  }

  void _invokeEvent() {
    final name = _eventNameController.text;
    final props = _eventProps.isEmpty ? null : Map<String, String>.of(_eventProps);
    if (props != null) {
      SurvicateSdk.invokeEvent(name, eventProperties: props);
    } else {
      SurvicateSdk.invokeEvent(name);
    }
    _appendLog('→ invokeEvent', {'eventName': name, 'properties': props});
  }

  void _addTrait() {
    final key = _traitKeyController.text;
    if (key.isEmpty) return;
    final value = _traitValueController.text;
    final trait = UserTrait.string(key, value);
    SurvicateSdk.setUserTrait(trait);
    _appendLog('→ setUserTrait', {'key': trait.key, 'value': trait.value});
    setState(() {
      _traits.add(_TraitEntry(_id(), trait.key, trait.value));
      _traitKeyController.clear();
      _traitValueController.clear();
    });
  }

  void _addResponseAttr() {
    final name = _attrNameController.text;
    if (name.isEmpty) return;
    final value = _attrValueController.text;
    final provider = _attrProviderController.text;
    final attr = ResponseAttribute.string(
      name,
      value,
      provider: provider.isEmpty ? null : provider,
    );
    SurvicateSdk.setResponseAttribute(attr);
    _appendLog('→ setResponseAttribute', {
      'name': attr.name,
      'value': attr.value,
      'provider': attr.provider,
    });
    setState(() {
      _responseAttrs.add(_AttrEntry(_id(), attr.name, attr.value, attr.provider));
      _attrNameController.clear();
      _attrValueController.clear();
      _attrProviderController.clear();
    });
  }

  void _enterScreen() {
    final name = _screenNameController.text;
    SurvicateSdk.enterScreen(name);
    _appendLog('→ enterScreen', {'screenName': name});
  }

  void _leaveScreen() {
    final name = _screenNameController.text;
    SurvicateSdk.leaveScreen(name);
    _appendLog('→ leaveScreen', {'screenName': name});
  }

  void _applyTheme(ThemeMode mode) {
    SurvicateSdk.setThemeMode(mode);
    _appendLog('→ setThemeMode', {'themeMode': mode.name});
  }

  void _applyLocale() {
    final tag = _localeController.text;
    SurvicateSdk.setLocale(tag);
    _appendLog('→ setLocale', {'languageTag': tag});
  }

  void _resetAll() {
    SurvicateSdk.reset();
    setState(() {
      _localeController.clear();
      _screenNameController.clear();
      _eventNameController.clear();
      _propKeyController.clear();
      _propValueController.clear();
      _eventProps.clear();
      _traitKeyController.clear();
      _traitValueController.clear();
      _traits.clear();
      _attrNameController.clear();
      _attrValueController.clear();
      _attrProviderController.clear();
      _responseAttrs.clear();
      _expandedIds.clear();
      _log
        ..clear()
        ..add(_LogEntry(_id(), DateTime.now(), '→ reset', const {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survicate Flutter Example',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Survicate Flutter Example', style: _Styles.title),

                _sectionTitle('Workspace key'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _workspaceKeyController,
                        enabled: !_sdkInitialized,
                        decoration: _inputDecoration('workspaceKey'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      title: 'Initialize SDK',
                      onPressed: _initializeSdk,
                      enabled: !_sdkInitialized &&
                          _workspaceKeyController.text.isNotEmpty,
                    ),
                  ],
                ),

                _sectionTitle('Events'),
                TextField(
                  controller: _eventNameController,
                  decoration: _inputDecoration('eventName'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _propKeyController,
                        decoration: _inputDecoration('key'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _propValueController,
                        decoration: _inputDecoration('value'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      title: 'Add',
                      onPressed: _addEventProp,
                      enabled: _sdkInitialized &&
                          _propKeyController.text.isNotEmpty,
                    ),
                  ],
                ),
                ..._eventProps.entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(child: Text('${e.key}: ${e.value}')),
                        _ActionButton(
                          title: 'Remove',
                          onPressed: () => _removeEventProp(e.key),
                          enabled: _sdkInitialized,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _ActionButton(
                  title: 'Invoke Event',
                  onPressed: _invokeEvent,
                  enabled: _sdkInitialized &&
                      _eventNameController.text.isNotEmpty,
                ),

                _sectionTitle('User Traits'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _traitKeyController,
                        decoration: _inputDecoration('key'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _traitValueController,
                        decoration: _inputDecoration('value'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      title: 'Set',
                      onPressed: _addTrait,
                      enabled: _sdkInitialized &&
                          _traitKeyController.text.isNotEmpty,
                    ),
                  ],
                ),
                ..._traits.map(
                  (t) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('${t.key}: ${t.value}'),
                  ),
                ),

                _sectionTitle('Screens'),
                TextField(
                  controller: _screenNameController,
                  decoration: _inputDecoration('screenName'),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        title: 'Enter Screen',
                        onPressed: _enterScreen,
                        enabled: _sdkInitialized &&
                            _screenNameController.text.isNotEmpty,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionButton(
                        title: 'Leave Screen',
                        onPressed: _leaveScreen,
                        enabled: _sdkInitialized &&
                            _screenNameController.text.isNotEmpty,
                      ),
                    ),
                  ],
                ),

                _sectionTitle('Response Attributes'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _attrNameController,
                        decoration: _inputDecoration('name'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _attrValueController,
                        decoration: _inputDecoration('value'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _attrProviderController,
                        decoration: _inputDecoration('provider'),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      title: 'Set',
                      onPressed: _addResponseAttr,
                      enabled: _sdkInitialized &&
                          _attrNameController.text.isNotEmpty,
                    ),
                  ],
                ),
                ..._responseAttrs.map(
                  (a) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '${a.name}: ${a.value}'
                      '${a.provider == null ? '' : ' (${a.provider})'}',
                    ),
                  ),
                ),

                _sectionTitle('Theme'),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        title: 'Light',
                        onPressed: () => _applyTheme(ThemeMode.light),
                        enabled: _sdkInitialized,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionButton(
                        title: 'Dark',
                        onPressed: () => _applyTheme(ThemeMode.dark),
                        enabled: _sdkInitialized,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ActionButton(
                        title: 'Auto',
                        onPressed: () => _applyTheme(ThemeMode.auto),
                        enabled: _sdkInitialized,
                      ),
                    ),
                  ],
                ),

                _sectionTitle('Locale'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _localeController,
                        decoration: _inputDecoration(
                          'languageTag (e.g. en-US)',
                        ),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      title: 'Apply',
                      onPressed: _applyLocale,
                      enabled: _sdkInitialized &&
                          _localeController.text.isNotEmpty,
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: () => setState(() => _logVisible = !_logVisible),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 8),
                    child: Text(
                      '${_logVisible ? '▾' : '▸'} Event Log'
                      '${_log.isNotEmpty ? ' (${_log.length})' : ''}',
                      style: _Styles.sectionTitle,
                    ),
                  ),
                ),
                if (_logVisible) ...[
                  _ActionButton(
                    title: 'Clear log',
                    onPressed: () => setState(() {
                      _log.clear();
                      _expandedIds.clear();
                    }),
                    enabled: _sdkInitialized && _log.isNotEmpty,
                  ),
                  if (_log.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'No events yet.',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF999999),
                        ),
                      ),
                    )
                  else
                    ..._log.map((entry) {
                      final expanded = _expandedIds.contains(entry.id);
                      return GestureDetector(
                        onTap: () => _toggleExpanded(entry.id),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFEEEEEE)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${expanded ? '▾' : '▸'} '
                                '${_formatTime(entry.ts)} · ${entry.type}',
                                style: _Styles.logHeader,
                              ),
                              if (expanded) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _prettyJson(entry.payload),
                                  style: _Styles.logPayload,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                ],

                _sectionTitle('Reset'),
                _ActionButton(
                  title: 'Reset',
                  onPressed: _resetAll,
                  enabled: _sdkInitialized,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Builders / formatters ---

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(text, style: _Styles.sectionTitle),
      );

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF999999)),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      );

  static String _formatTime(DateTime ts) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(ts.hour)}:${two(ts.minute)}:${two(ts.second)}';
  }

  static String _prettyJson(Object? payload) {
    try {
      return const JsonEncoder.withIndent('  ').convert(payload);
    } catch (_) {
      return payload.toString();
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool enabled;

  const _ActionButton({
    required this.title,
    required this.onPressed,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        constraints: const BoxConstraints(minHeight: 36),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF0A84FF) : const Color(0xFFD0D0D0),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: enabled ? Colors.white : const Color(0xFF888888),
            fontWeight: FontWeight.w600,
            fontSize: 13,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

class _LogEntry {
  final int id;
  final DateTime ts;
  final String type;
  final Object? payload;

  _LogEntry(this.id, this.ts, this.type, this.payload);
}

class _TraitEntry {
  final int id;
  final String key;
  final String value;

  _TraitEntry(this.id, this.key, this.value);
}

class _AttrEntry {
  final int id;
  final String name;
  final String value;
  final String? provider;

  _AttrEntry(this.id, this.name, this.value, this.provider);
}

class _Styles {
  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const sectionTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const logHeader = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Colors.black,
  );
  static const logPayload = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    color: Color(0xFF333333),
  );
}
