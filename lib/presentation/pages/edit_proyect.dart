import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_to_do/logic/edit_proyect/edit_proyect_cubit.dart';
import 'package:focus_to_do/logic/list_proyect/list_proyect_cubit.dart';
import 'package:focus_to_do/presentation/utils/arguments_page.dart';
import 'package:focus_to_do/presentation/utils/constants.dart';

class EditProyectPage extends StatelessWidget {
  const EditProyectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // recibe arguments from push router
    final project =
        ModalRoute.of(context)!.settings.arguments as ArgumentEditProyectPage;
    print(project.color);
    return BlocProvider.value(
      value: editProyectCubit..init(project.name, project.color, project.id),
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
                  editProyectCubit.submit();
                  // createProyectCubit.submit();
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
              const Text("Editar Proyecto", style: AppTextStyles.primaryColor),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              color: AppColors.white,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  BlocBuilder<EditProjectCubit, EditProjectState>(
                    builder: (context, state) {
                      return Icon(Icons.circle,
                          color: AppColors.colorPicker[state.indexColor],
                          size: 26);
                    },
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: BlocBuilder<EditProjectCubit, EditProjectState>(
                      builder: (context, state) {
                        return TextFormField(
                          initialValue: project.name,
                          onChanged: (value) =>
                              editProyectCubit.changeName(value),
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
              child: BlocBuilder<EditProjectCubit, EditProjectState>(
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
                          editProyectCubit.changeColor(index);
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
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                listProyectCubit.deleteOneProyect(project.id);
                Navigator.pop(context);
              },
              child: Container(
                color: AppColors.white,
                width: double.infinity,
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Eliminar proyecto",
                  style: TextStyle(
                      color: AppColors.highPriorityColor, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
