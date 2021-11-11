import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImagemCadastro extends StatelessWidget {
  const ImagemCadastro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(),
                  Positioned(
                    right: -5,
                    bottom: 0,
                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0XFF0380E3),
                      ),
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo_outlined),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ImagemPerfil extends StatelessWidget {
  final String? imageUri;

  const ImagemPerfil({Key? key, this.imageUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uri;
    imageUri == "null" ? uri = "" : uri = imageUri.toString();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: uri.isEmpty ? null : NetworkImage(uri),
                child: uri.isEmpty
                    ? SvgPicture.asset(
                        "assets/images/fotoPadrao.svg",
                        allowDrawingOutsideViewBox: true,
                        height: 160,
                      )
                    : null,
              ),
            ),
          ),
        )
      ],
    );
  }
}
