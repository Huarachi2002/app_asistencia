
import 'dart:async';

import 'package:app_asistencia/config/api/apiServicio.dart';
import 'package:app_asistencia/config/theme/paletaColors.dart';
import 'package:app_asistencia/provider/user_provider.dart';
import 'package:app_asistencia/widget/card_materia.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  late Timer _timer;
  List<dynamic> data = [];
  bool load = true;

  void logout() {
    context.go('/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHorario(context);
    _timer = Timer(const Duration(seconds: 2), 
      () {
        setState(() {
          load = !load;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  Future<void> getHorario(BuildContext context)async{
    try {
      final docente = Provider.of<UserProvider>(context, listen: false).id;
      final response = await dio.get(
        '/detalle_carga_horaria/docente/$docente'
      );
      data = response.data['data'];
    } on DioException catch (e) {
        if(e.response != null){
          print('headers: ${e.response!.headers}');
          print('requestOptions: ${e.response!.requestOptions}');
          print('data: ${e.response!.data}');
        }
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_rounded,),
                label: 'Horario',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment), 
                label: 'Solicitar Licencia'
              ),
            ]),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Center(
            child: Text(
              'DOCENTECHECK',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  fontSize: 23),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
              )
            ),
          ],
        ),
        body: (false) 
          ? const Center(child: CircularProgressIndicator(),)
          :
            (currentIndex == 0)
            ? _HorarioView(data: data,)
            : const _LicenciaView()
      );
  }
}

class _HorarioView extends StatelessWidget {
  final List<dynamic> data;
  _HorarioView({
    super.key, required this.data,
  });

  List<String> dias = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min  ,
            children: [
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Horario',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        fontSize: 35
                    ),
                  ),
                  IconButton(onPressed: (){ context.push('/qr');}, icon: const Icon(Icons.qr_code))
                ],
              ),
              
              const Divider(
                thickness: 3,
                color: widgetColor,
              ),
              const SizedBox(height: 10,),
              const Text(
                'Lunes',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 25
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if(dias[0] == data[index]['dias']['nombre']) {
                    return CardMateria(
                      nombreMateria: data[index]['cargaHoraria']['materia']['nombre'], 
                      siglaMateria: data[index]['cargaHoraria']['materia']['sigla'], 
                      grupoMateria: data[index]['grupo']['nombre'], 
                      numAula: data[index]['aula']['nombre'], 
                      numModulo: data[index]['aula']['modulo']['numero'], 
                      dia: dias[index], 
                      horaInit: data[index]['hora_inicio'], 
                      horaFin: data[index]['hora_fin']
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20,),
              const Text(
                'Martes',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 25
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if(dias[1] == data[index]['dias']['nombre']) {
                    return CardMateria(
                      nombreMateria: data[index]['cargaHoraria']['materia']['nombre'], 
                      siglaMateria: data[index]['cargaHoraria']['materia']['sigla'], 
                      grupoMateria: data[index]['grupo']['nombre'], 
                      numAula: data[index]['aula']['nombre'], 
                      numModulo: data[index]['aula']['modulo']['numero'], 
                      dia: dias[index], 
                      horaInit: data[index]['hora_inicio'], 
                      horaFin: data[index]['hora_fin']
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20,),
              const Text(
                'Miercoles',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 25
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if(dias[2] == data[index]['dias']['nombre']) {
                    return CardMateria(
                      nombreMateria: data[index]['cargaHoraria']['materia']['nombre'], 
                      siglaMateria: data[index]['cargaHoraria']['materia']['sigla'], 
                      grupoMateria: data[index]['grupo']['nombre'], 
                      numAula: data[index]['aula']['nombre'], 
                      numModulo: data[index]['aula']['modulo']['numero'], 
                      dia: dias[index], 
                      horaInit: data[index]['hora_inicio'], 
                      horaFin: data[index]['hora_fin']
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20,),
              const Text(
                'Jueves',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 25
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if(dias[3] == data[index]['dias']['nombre']) {
                    return CardMateria(
                      nombreMateria: data[index]['cargaHoraria']['materia']['nombre'], 
                      siglaMateria: data[index]['cargaHoraria']['materia']['sigla'], 
                      grupoMateria: data[index]['grupo']['nombre'], 
                      numAula: data[index]['aula']['nombre'], 
                      numModulo: data[index]['aula']['modulo']['numero'], 
                      dia: dias[index], 
                      horaInit: data[index]['hora_inicio'], 
                      horaFin: data[index]['hora_fin']
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20,),
              const Text(
                'Viernes',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 25
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if(dias[4] == data[index]['dias']['nombre']) {
                    return CardMateria(
                      nombreMateria: data[index]['cargaHoraria']['materia']['nombre'], 
                      siglaMateria: data[index]['cargaHoraria']['materia']['sigla'], 
                      grupoMateria: data[index]['grupo']['nombre'], 
                      numAula: data[index]['aula']['nombre'], 
                      numModulo: data[index]['aula']['modulo']['numero'], 
                      dia: dias[index], 
                      horaInit: data[index]['hora_inicio'], 
                      horaFin: data[index]['hora_fin']
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20,),
              const Text(
                'Sabado',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                    fontSize: 25
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  if(dias[5] == data[index]['dias']['nombre']) {
                    return CardMateria(
                      nombreMateria: data[index]['cargaHoraria']['materia']['nombre'], 
                      siglaMateria: data[index]['cargaHoraria']['materia']['sigla'], 
                      grupoMateria: data[index]['grupo']['nombre'], 
                      numAula: data[index]['aula']['nombre'], 
                      numModulo: data[index]['aula']['modulo']['numero'], 
                      dia: dias[index], 
                      horaInit: data[index]['hora_inicio'], 
                      horaFin: data[index]['hora_fin']
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


List<String> options = [
  'Enfermedad',
  'Problemas de Salud',
  'Problemas Personales',
  'Emergencia Familiares',
  'Fallecimiento de un Familiar',
  'Tramites Administrativos',
  'Problemas Legales',
  'Otro'
];

class _LicenciaView extends StatefulWidget {
  const _LicenciaView({super.key});

  @override
  State<_LicenciaView> createState() => _LicenciaViewState();
}

class _LicenciaViewState extends State<_LicenciaView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String currentOption = options[0];
  String motivoValue = options[0];
  String descriptionValue = '';
  int _charCount = 0;
  final int _maxChars = 300;
  DateTime selectedDate = DateTime.now();
  late TextEditingController textController;
  late TextEditingController textFromController;


  Future<void> licencia ()async{
    print(motivoValue);
    print(descriptionValue);
    print(selectedDate);
    try {
      final tokenUser = Provider.of<UserProvider>(context, listen: false).token;
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $tokenUser',
        'Content-Type': 'application/json',
      };

      await dio.post(
        '/licencia',
        data: {
          "titulo": motivoValue,
          "descripcion": descriptionValue,
          "fecha": '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'
        },
        options: Options(
          headers: headers
        )
      );
    } on DioException catch (e) {
        if(e.response != null){
          print('headers: ${e.response!.headers}');
          print('requestOptions: ${e.response!.requestOptions}');
          print('data: ${e.response!.data}');
        }
    } 
  }

  void resertValue(){
    setState(() {
      currentOption = options[0];
      motivoValue = currentOption;
      textController.clear();
      textFromController.clear();
      descriptionValue ='';
      selectedDate = DateTime.now();
      _charCount = 0;
    });
    print(motivoValue);
    print(descriptionValue);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _charCount = descriptionValue.length;
      textController = TextEditingController();
      textFromController = TextEditingController();
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textController.dispose();
    textFromController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      // borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(5)
    );


    return Container(
          width: double.infinity,
          color: backgroundColor2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: _formKey,
                child: ListView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Solicitar Licencia',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontSize: 35),
                        ),
                        const Divider(
                          thickness: 3,
                          color: widgetColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Motivo',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontSize: 25
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                title: Text(options[index]),
                                value: options[index],
                                groupValue: currentOption,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value.toString();
                                    motivoValue = currentOption;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        if (currentOption == 'Otro')
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: textController,
                              onSubmitted: (String value) {
                                setState(() {
                                  motivoValue = textController.text;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Escriba el motivo en especifico',
                              ),
                            ),
                          ),

                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Descripcion',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                              fontSize: 25
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: textFromController,
                          scrollController: ScrollController(),
                          maxLines: null,
                          onChanged: (value) {
                            setState(() {
                              descriptionValue = value;
                              _charCount = descriptionValue.length;
                            });
                          },
                          autocorrect: true,
                          maxLength: _maxChars,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese una descripción';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            
                            counterText: '$_charCount/$_maxChars',
                            enabledBorder: border,
                            focusedBorder: border.copyWith(borderSide: const BorderSide(color: widgetColor)),
                            errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade700)),
                            isDense: true,
                            focusColor: widgetColor,
                    
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                              ElevatedButton.icon(
                                onPressed: () async{
                                  final DateTime? dateTime = await showDatePicker(
                                    context: context, 
                                    initialDate: selectedDate,
                                    firstDate: DateTime(2000), 
                                    lastDate: DateTime(3000)
                                  );
                                  if(dateTime != null){
                                    setState(() {
                                      selectedDate = dateTime;
                                    });
                                  }
                                },
                                label: const Text('Seleccionar Fecha'), 
                                icon: const Icon(Icons.calendar_month_rounded),  
                              ),
                            ],
                          ),
                        ),
                        
                        
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                final isValid = _formKey.currentState!.validate();
                                if(!isValid) return;
                                licencia();
                                resertValue();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Formulario Enviado'))
                                );
                              }, 
                          
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color>(buttonColor),
                              ),
                              child: const Text(
                                'Enviar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                                ),
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
            ),
          ),
        );
  }
}