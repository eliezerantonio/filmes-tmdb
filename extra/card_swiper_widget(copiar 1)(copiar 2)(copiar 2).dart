import 'package:filmes/src/models/filmes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Filme> filmes;

  CardSwiper({@required this.filmes}); //@required- forcar

  @override
  Widget build(BuildContext context) {
    final _screenSize =
        MediaQuery.of(context).size; //tamnho da tela do dispotivo

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          filmes[index].uiniqueId = '${filmes[index].id}-cartao';

          return Hero(
            tag: filmes[index].uiniqueId,
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(20.0), //redondar as pontas
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalhe',
                    arguments: filmes[index]),
                child: FadeInImage(
                  image: NetworkImage(
                    filmes[index].getPosterImg(),
                  ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: filmes.length,

        //pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
