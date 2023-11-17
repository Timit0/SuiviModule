import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suivi_de_module/models/eleve.dart';
import 'package:suivi_de_module/provider/student_provider.dart';
import 'package:suivi_de_module/widget/eleve_gestion_form.dart';
import 'package:suivi_de_module/widget/student_list_grid_widget.dart';

import '../enum/eleve_state.dart';

class EleveAddEditScreen extends StatefulWidget {
  EleveAddEditScreen({super.key});

  @override
  State<EleveAddEditScreen> createState() => _EleveAddEditScreenState();
}

class _EleveAddEditScreenState extends State<EleveAddEditScreen> {
  EleveState formState = EleveState.Create;

  final _form = GlobalKey<FormState>();

  final TextEditingController getCp = TextEditingController();

  final TextEditingController getName = TextEditingController();

  final TextEditingController getNickName = TextEditingController();

  final TextEditingController getPicture = TextEditingController();

  var _isInit = true;
  var _isLoading = false;

  bool disposeOption = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      _isLoading = true;
      await Provider.of<StudentProvider>(context, listen: false)
          .fetchAndSetAllStudents();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StudentListGridWidget(),
        Flexible(
          child: EleveGestionForm(
            disposeOption: disposeOption,
            formState: formState,
            form: _form,
            getCp: getCp,
            getName: getName,
            getNickName: getNickName,
            getPicture: getPicture,
          ),
        ),
      ],
    );
  }
}
