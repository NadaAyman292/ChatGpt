import 'package:chatgpt_course/providers/mode;_provider.dart';
import 'package:chatgpt_course/services/api_services.dart';
import 'package:chatgpt_course/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/models_model.dart';
import '../providers/mode;_provider.dart';
import '../providers/mode;_provider.dart';

class ModelsDropDownSheet extends StatefulWidget {
  const ModelsDropDownSheet({super.key});

  @override
  State<ModelsDropDownSheet> createState() => _ModelsDropDownSheetState();
}

class _ModelsDropDownSheetState extends State<ModelsDropDownSheet> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context, listen: false);
    currentModel = modelProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelProvider.getAllModels(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                      dropdownColor: scaffoldBackgroundColor,
                      iconEnabledColor: Colors.white,
                      items: List<DropdownMenuItem<String>>.generate(
                          snapshot.data!.length,
                          (index) => DropdownMenuItem(
                              value: snapshot.data![index].id,
                              child: TextWidget(
                                label: snapshot.data![index].id,
                                fontSize: 15,
                              ))),
                      value: currentModel,
                      onChanged: (value) {
                        setState(() {
                          currentModel = value.toString();
                        });
                        modelProvider.setCurrentModel(value.toString());
                      }),
                );
        }));
  }
}

/** DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
        items: getModelsItem,
        value: currentModel,
        onChanged: (value) {
          setState(() {
            currentModel = value.toString();
          });
        }) **/
