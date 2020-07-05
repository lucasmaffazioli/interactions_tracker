import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/presentation/add_approach_page/controller.dart';
import 'package:cold_app/presentation/add_approach_page/form_input/base_form_input.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/base_app_bar.dart';
import 'form_input/date_form_input.dart';
import 'form_input/text_form_input.dart';
import 'form_input/time_form_input.dart';

class AddApproachPage extends StatelessWidget {
  ApproachPresentation approachPresentation = ApproachPresentation();
  final AddApproachController controller = AddApproachController();

  final _formKey = GlobalKey<FormState>();

  String _requiredValidator(value) {
    print('value');
    print(value);
    if (value == null || value == '') {
      return 'Valor obrigaório!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // ApproachPresentation approachPresentation = controller.getApproach();

    return Scaffold(
      appBar: BaseAppBar(
        'Nova Abordagem',
        appBar: AppBar(),
        hasBackButton: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          // child: _Points(),
          // child: Column(
          //   children: <Widget>[
          //     Row(
          //       mainAxisSize: MainAxisSize.max,
          //       children: <Widget>[
          //         Expanded(
          //           child: DateFormInput(
          //             title: 'Data *',
          //             validator: _requiredValidator,
          //             onSave: ((value) {
          //               approachData.date = value;
          //             }),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 25,
          //         ),
          //         Expanded(
          //           child: TimeFormInput(
          //             title: 'Hora *',
          //             onSave: ((value) {
          //               approachData.time = value;
          //             }),
          //           ),
          //         ),
          //       ],
          //     ),
          //     TextFormInput(
          //       title: 'Nome *',
          //       validator: _requiredValidator,
          //       onSave: ((value) {
          //         approachData.name = value;
          //       }),
          //     ),
          //     TextFormInput(
          //       title: 'Resumo *',
          //       validator: _requiredValidator,
          //       onSave: ((value) {
          //         approachData.description = value;
          //       }),
          //     ),
          //     TextFormInput(
          //       title: 'Notas',
          //       maxLines: 5,
          //       minLines: 3,
          //       onSave: ((value) {
          //         approachData.notes = value;
          //       }),
          //     ),
          //     _PointWithSlider('Habilidades',
          //         iconData: FontAwesomeIcons.pollH, children: skillItems),
          //     _PointWithSlider('Atração',
          //         iconData: FontAwesomeIcons.solidHeart, children: attractionItems),
          //     _PointWithSlider('Resultado',
          //         iconData: FontAwesomeIcons.medal, children: resultItems),
          //     RaisedButton(
          //       onPressed: () {
          //         // Validate returns true if the form is valid, otherwise false.
          //         if (_formKey.currentState.validate()) {
          //           _formKey.currentState.save();
          //           print('approachData.date');
          //           print(approachData.date);
          //           print(approachData.time);
          //           print(approachData.name);
          //           // If the form is valid, display a snackbar. In the real world,
          //           // you'd often call a server or save the information in a database.

          //         }
          //       },
          //       child: Text('Submit'),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

// class _Points extends StatelessWidget {
//   final AddApproachController controller = AddApproachController();

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       // Let the ListView know how many items it needs to build.
//       itemCount: items.length,

//       itemBuilder: (context, index) {
//         final item = items[index];
//         // final List<Widget> approaches = [];
//         if (item.isMonth) {
//           return Center(
//               child: Text(
//             item.month,
//             style: Constants.textH1,
//           ));
//         } else {
//           return MyCard(
//             title: item.title,
//             description: item.description,
//             month: item.month,
//             day: item.day,
//             skill: item.skill,
//             attraction: item.attraction,
//             result: item.result,
//           );
//         }
//       },
//     );
//   }
// }

class _TitleWithSlider extends StatelessWidget {
  final int id;
  final String name;
  final Function onSave;

  const _TitleWithSlider({
    Key key,
    @required this.id,
    @required this.name,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}

class _PointWithSlider extends StatelessWidget {
  final String title;
  final IconData iconData;
  final List<Widget> children;

  const _PointWithSlider(this.title, {Key key, this.iconData, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleWithIcon(
          'Habilidades',
          iconData: FontAwesomeIcons.pollH,
        ),
        Column(
          children: children,
        ),
      ],
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData iconData;

  const TitleWithIcon(
    this.title, {
    Key key,
    @required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FaIcon(
          iconData,
          color: Constants.mainTextColor,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Constants.textH1,
        ),
      ],
    );
  }
}
