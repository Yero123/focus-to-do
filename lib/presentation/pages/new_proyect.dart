import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_to_do/logic/create_proyect/create_proyect_cubit.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class NewProyectPage extends StatelessWidget {
  const NewProyectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController _controller = TextEditingController();
    // @override
    // void initState() {
    //   super.initState();
    //   _controller.text = 'Texto inicial aquí'; // Establece el valor inicial
    // }

    return BlocProvider.value(
      value: createProyectCubit,
      child: Center(
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.close, color: AppColors.gray),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              InkWell(
                  onTap: () {
                    createProyectCubit.submit();
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Listo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ],
                  )),
              const SizedBox(width: 25),
            ],
            title:
                const Text("Nuevo Proyecto", style: AppTextStyles.primaryColor),
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                color: AppColors.white,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    BlocBuilder<CreateProjectCubit, CreateProjectState>(
                      builder: (context, state) {
                        return Icon(Icons.circle,
                            color: AppColors.colorPicker[state.indexColor],
                            size: 26);
                      },
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child:
                          BlocBuilder<CreateProjectCubit, CreateProjectState>(
                        builder: (context, state) {
                          return TextField(
                            onChanged: (value) =>
                                createProyectCubit.changeName(value),
                            decoration: InputDecoration(
                              hintText: "Nombre del proyecto",
                              hintStyle: TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: AppColors.white,
                height: 260,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<CreateProjectCubit, CreateProjectState>(
                  builder: (context, state) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(20),

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 40,
                        mainAxisSpacing: 15,
                        // Puedes ajustar el número de columnas aquí
                      ),
                      itemCount: AppColors.colorPicker
                          .length, // Cambia este número según la cantidad de círculos que desees
                      itemBuilder: (context, index) {
                        // Genera un color aleatorio para cada círculo
                        final color = AppColors.colorPicker[index];
                        bool isChoised = state.indexColor == index;
                        return GestureDetector(
                          onTap: () {
                            createProyectCubit.changeColor(index);
                          },
                          child: Container(
                            width: 100,
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color,
                                ),
                                child: isChoised
                                    ? const Center(
                                        child: Icon(Icons.check,
                                            size: 26, color: Colors.white))
                                    : SizedBox()),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
