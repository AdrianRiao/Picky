program alumnos;

consts:

	NumAlums = 5;

types:
	
	TipoNif = record
	{
		numero: int;
		letra: char;
	};
	
	TipoRama = (Ciencias, Ingenieria, Humanidades);
	
	TipoAlum = record
	{
		nif: TipoNif;
		rama: TipoRama;
		nota: float;
	};

	TipoRango = int 0..(NumAlums-1);

	TipoAlums = array[TipoRango] of TipoAlum;
	
	TipoLetraOK = array[0..22] of char;

function media(numerador: float, denominador: int): float
{
	return numerador / float(denominador);
}

procedure escribirmedia(alums: TipoAlums, rama: TipoRama)
	numalums: int;
	sumanotas: float;
	i: int;
	alum: TipoAlum; /* es cada alumno en concreto */
{
	numalums = 0;
	sumanotas = 0.0;
	for(i = 0, i < len alums){
		alum = alums[i];
		if(alum.rama == rama){
			sumanotas = (sumanotas + alum.nota);
			numalums = (numalums + 1);
		}
	}
	if(numalums != 0){
	/* 
	 * Añado esta condicion para que no se de el 
	 * caso de que el programa divida entre cero
	 */
		write("MEDIA: ");
		writeln(media(sumanotas, numalums));
	}
}

procedure escribirnota(alum: TipoAlum)
{
	write("NOTA: ");
	write(alum.nota);
}

procedure escribirrama(alum: TipoAlum)
{
	write("RAMA: ");
	write(alum.rama);
}

procedure escribirletra(nif: TipoNif)
{
	write(nif.letra);
}

procedure escribirnumero(nif: TipoNif)
{
	write(nif.numero);
}

procedure escribirnif(alum: TipoAlum)
{
	write("NIF: ");
	escribirnumero(alum.nif);
	escribirletra(alum.nif);
}

procedure escribirdatos(alum: TipoAlum)
{
	write("(");
	escribirnif(alum);
	write(", ");
	escribirrama(alum);
	write(", ");
	escribirnota(alum);
	writeln(")");
}

procedure escribiralums(alums: TipoAlums, rama: TipoRama)
	i: int;
	alum: TipoAlum; /* es cada alumno en concreto */
{
	for(i = 0, i < len alums){
		alum = alums[i];
		if(alum.rama == rama){
			escribirdatos(alum);
		}
	}
}

function letracorrecta(alum: TipoAlum, letraok: TipoLetraOK): char
{
	return letraok[alum.nif.numero % 23];
}

function nifcorrecto(alum: TipoAlum, letraok: TipoLetraOK): bool
{
	return alum.nif.letra == letracorrecta(alum, letraok);
}

procedure leernif(ref nif:TipoNif)
{
	readln(nif.numero);
	readln(nif.letra);
}

procedure leeralum(ref alum: TipoAlum)
{
	leernif(alum.nif);
	readln(alum.rama);
	readln(alum.nota);
}

consts:

	LetraOK = TipoLetraOK('T', 'R', 'W', 'A', 'G', 'M', 'Y', 
							'F', 'P', 'D', 'X', 'B', 'N', 'J', 'Z',
							'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E');
				
procedure main()
	alums: TipoAlums;
	alum: TipoAlum;
	seguir: bool; /* Seguir en el bucle */
	i: int;
	letraok: TipoLetraOK;
	rama: TipoRama;
{
	seguir = True;
	i = 0;
	letraok = LetraOK;
	
	do{
		leeralum(alum);
		if(nifcorrecto(alum, letraok)){
			alums[i] = alum;
			i = i + 1;
		}else{
			writeln("NIF incorrecto");
			seguir = False;
		}
	}while((i < len alums) and seguir);
	
	if(seguir){
		readln(rama);
		escribiralums(alums, rama);
		escribirmedia(alums, rama);
	}
}
