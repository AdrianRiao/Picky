program ordenar;

consts:

	MaxCartas = 100;
	
	MaxValor = 10;
	
	MinValor = 1;
	
types:

	TipoValor = int MinValor..MaxValor;
	
	TipoPalo = (Oros, Copas, Espadas, Bastos);
	
	TipoCarta = record
	{
		palo: TipoPalo;
		valor: TipoValor;
	};
	
	TipoCartas = array[0..(MaxCartas - 1)] of TipoCarta;

procedure imprimircarta(carta: TipoCarta)
{
	write("[");
	write(carta.palo);
	write(", ");
	write(carta.valor);
	writeln("]");
}

procedure imprimircartas(cartas: TipoCartas, numcartas: int)
	i: int;
	carta: TipoCarta;
{
	for(i = 0, i < numcartas){
		carta = cartas[i];
		imprimircarta(carta);
	}	
}

procedure intercambiar(ref cartas: TipoCartas,ref pos1: int, pos2: int)
	aux: TipoCarta;
{
	aux = cartas[pos1];
	cartas[pos1] = cartas[pos2];
	cartas[pos2] = aux;
}

function esmenorc2(c1: TipoCarta, c2: TipoCarta): bool
{
	return c2.valor < c1.valor;
}

procedure ordenarvalores(ref cartas: TipoCartas, inicio: int, final: int)
	i: int;
	j: int;
	inicio1: int;
	carta1: TipoCarta;
	carta2: TipoCarta;
{
	for(i = inicio, i < final){
		carta1 = cartas[i];
		inicio1 = i + 1;
		for(j = inicio1, j < final){
			carta2 = cartas[j];
			if(esmenorc2(carta1, carta2)){
				intercambiar(cartas, i, j);
				carta1 = cartas[i];
			}
		}
	}
	
}

function espalook(carta: TipoCarta, palo: TipoPalo): bool
{
	return carta.palo == palo;
}

procedure ordenarpalo(ref cartas: TipoCartas, numcartas: int,
						inicio: int, ref final: int, palo: TipoPalo)
	i: int;
	carta: TipoCarta;
{
	for(i = inicio, i < numcartas){
		carta = cartas[i];
		if(espalook(carta, palo)){
			intercambiar(cartas, final, i);
			final = final+1;
		}
	}
}

procedure ordenarbastos(ref cartas: TipoCartas, numcartas: int,
						ref final: int)
	inicio: int; /*
				  * Es desde donde estan ordenados
				  * las copas.
				  */
	palo: TipoPalo;
{
	inicio = final;
	palo = Bastos;
	ordenarpalo(cartas, numcartas, inicio, final, palo);
	ordenarvalores(cartas, inicio, final);
}

procedure ordenarespadas(ref cartas: TipoCartas, numcartas: int,
						ref final: int)
	inicio: int; /*
				  * Es desde donde estan ordenados
				  * las copas.
				  */
	palo: TipoPalo;
{
	inicio = final;
	palo = Espadas;
	ordenarpalo(cartas, numcartas, inicio, final, palo);
	ordenarvalores(cartas, inicio, final);
}

procedure ordenarcopas(ref cartas: TipoCartas, numcartas: int,
						ref final: int)
	inicio: int; /*
				  * Es desde donde estan ordenados
				  * las copas.
				  */
	palo: TipoPalo;
{
	inicio = final;
	palo = Copas;
	ordenarpalo(cartas, numcartas, inicio, final, palo);
	ordenarvalores(cartas, inicio, final);
}

procedure ordenaroros(ref cartas: TipoCartas, numcartas: int,
						ref final: int)
	inicio: int; /*
				  * Es desde donde estan ordenados
				  * los oros.
				  */
	palo: TipoPalo;
{
	inicio = final;
	palo = Oros;
	ordenarpalo(cartas, numcartas, inicio, final, palo);
	ordenarvalores(cartas, inicio, final);
}

procedure ordenarcartas(ref cartas: TipoCartas, numcartas: int)
	ultordenado: int; /* 
				    * Es la posicion hasta la que
				    * el array esta ordenado.
				    */
{
	ultordenado = 0;
	ordenaroros(cartas, numcartas, ultordenado);
	ordenarcopas(cartas, numcartas, ultordenado);
	ordenarespadas(cartas, numcartas, ultordenado);
	ordenarbastos(cartas, numcartas, ultordenado);
}

procedure guardarcarta(carta: TipoCarta, ref cartas: TipoCartas, numcartas: int)
	numcarta: int;
{
	numcarta = (numcartas-1);
	cartas[numcarta] = carta;
}

procedure leercarta(ref carta: TipoCarta)
{
	readln(carta.palo);
	readln(carta.valor);
}

function eseof(c: char): bool
{
	return c == Eof;
}

procedure main()
	carta: TipoCarta;
	cartas: TipoCartas;
	numcartas: int;
	c: char;
	continuar: bool;
{
	numcartas = 0;
	continuar = True;
	
	do{
		peek(c);
		if(not eseof(c)){
			leercarta(carta);
			numcartas = numcartas + 1;
			if(numcartas <= MaxCartas){
				guardarcarta(carta, cartas, numcartas);
			}else{
				continuar = False;
			}
		}
	}while(not eseof(c) and continuar);
	
	if(continuar){
		ordenarcartas(cartas, numcartas);
		imprimircartas(cartas, numcartas);
	}
}
