// import 'dart:js';

// import 'package:component_library/component_library.dart';
// import 'package:flutter/material.dart';
// import 'package:storybook_flutter/storybook_flutter.dart';
// import 'package:suivi_de_module/models/eleve.dart';


// List<Story> getStories() => [
//   Story(
//     name: 'Widgets/buttons/add_card_widget',
//     builder: (context) => AddCardWidget(
//       type: context.knobs.options(label: 'mode', initial: CardState.Devoir, options: [
//         const Option(label: 'Devoir', value: CardState.Devoir),
//         const Option(label: 'Test', value: CardState.Test)
//       ])
//     )
//   ),
//   Story(
//     name: 'Widgets/module_widget',
//     builder: (context) {
//       final output = ModuleWidget(
//         nom: context.knobs.text(label: 'Nom du module', initial: 'ICH-123'),
//         description: context.knobs.text(label: 'Description du module'),
//         horaire: context.knobs.text(label: 'date du module'),
//         classe: context.knobs.text(label: 'Nom de la classe'),
//         eleve: [],
//         editionBehavior: null,
//         presentationMode: true
//       );

//       return output.buildWidget(context, 0);
//     }
//   ),
//   Story(
//     name: 'Widgets/cards/devoir_test_widget',
//     builder: (context) => DevoirTestWidget(
//       args: context.knobs.text(label: 'text'),
//       presentationMode: true
//     )
//   ),
//   Story(
//     name: 'Widgets/cards/eleve_card_widget',
//     builder: (context) => EleveCardWidget(
//       eleve: Eleve.base()
//     )
//   ),
//   Story(  
//     name: 'Widgets/BottomNavigationBar/app_navigation_bar_widget',
//     builder: (context) => AppBottomNavigationBar(
//       stage: context.knobs.options(
//         label: 'Stage', 
//         initial: Stage.module,
//         options: [
//           const Option(
//             label: 'Module', 
//             value: Stage.module
//           ),
//           const Option(
//             label: 'list des eleves',
//             value: Stage.eleves
//           ),
//           const Option(
//             label: 'detail d\'un eleve',
//             value: Stage.eleveDetail
//           )
//         ]
//       )
//     )
//   ),
//   Story(
//     name: 'Widgets/avatar/avatar_widget',
//     builder: (context) => AvatarWidget(
//       photoUrl: context.knobs.text(label: 'image URL')
//     )
//   ),
//   Story(
//     name: 'Widgets/check_widget',
//     builder: (context) => CheckWidget(
//       checkState: context.knobs.boolean(label: 'checked', initial: false),
//     ),
//   ),
//   Story(
//     name: 'Widgets/navigation_rail/app_navigation_rail',
//     builder: (context) => const AppNavigationRail()
//   )
// ];