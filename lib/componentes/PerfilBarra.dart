import 'package:app_consultor/controladores/ControladorUsuario.dart';
import 'package:app_consultor/modelos/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//implementa o statelessWidget com PreferredSizeWidget para que a appbar reconheça o widget
class PerfilBarra extends StatelessWidget implements PreferredSizeWidget {
  const PerfilBarra({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(76); // meterodo obrigatorio para sobreescrita
  @override
  Widget build(BuildContext context) {
    Usuario usuario = GetIt.I.get<ControladorUsuario>().usuario;
    return Container(
      margin: MediaQuery.of(context).padding,
      width: MediaQuery.of(context).size.width,
      height: 76,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: 60,
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  {
                    Navigator.pushNamed(context, "/telaPerfil");
                  }
                },
                child: ClipOval(
                  child: Container(
                    height: 80,
                    child: Image.network(
                      usuario.urlFoto.toString(),
                      fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        //constroi um loading na tela até que a imagem carregue
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Container(
                          height: 80,
                          child: ClipOval(
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(usuario.nome.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(usuario.unidade!.nome.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: RawMaterialButton(
              fillColor: Colors.grey,
              shape: CircleBorder(),
              onPressed: () {
                Navigator.pushNamed(context, "/telaUnidades");
              },
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[50]),
                child: Icon(
                  Icons.swap_horiz_outlined,
                  size: 25,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
