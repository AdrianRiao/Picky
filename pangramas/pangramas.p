program pangramas;

consts:

	Neutro = 0;

	MaxNCaracts = 100;
	
	MaxNFrases = 100;
	
	LetraIMayus = 'A'; /*
						* Es la letra inicial del 
						* abecedario en mayuscula
						*/

	LetraFMayus = 'Z'; /*
						* Es la letra final del 
						* abecedario en mayuscula
						*/

	LetraIMinus = 'a'; /*
						* Es la letra inicial del 
						* abecedario en minuscula
						*/

	LetraFMinus = 'z'; /*
						* Es la letra final del 
						* abecedario en minuscula
						*/

types:

	TipoArrCaracts = array[Neutro..(MaxNCaracts - 1)] of char;
	
	TipoFrase = record
	{
		caracts: TipoArrCaracts;
		ncaracts: int;
	};
	
	TipoFrases = array[Neutro..(MaxNFrases - 1)] of TipoFrase;
	
	TipoTexto = record
	{
		frases: TipoFrases;
		nfrases: int;
	};
	
	TipoPangrama = array[LetraIMayus..LetraFMayus] of bool;

procedure escribirfrase(frase: TipoFrase)
	i: int;
{
	for(i = Neutro, i < frase.ncaracts){
		write(frase.caracts[i]);
	}
	writeeol();
}

function estruepangrama(pangrama: TipoPangrama): bool
	c: char;
	loes: bool;
{
	c = LetraIMayus;
	loes = True;
	do{
		if(pangrama[c] == True){
			c = char(int(c) + 1);
		}else{
			loes = False;
		}
	}while(loes and c <= LetraFMayus);
	
	return loes;
}

procedure inicializarpangrama(ref pangrama: TipoPangrama)
	c: char;
{
	for(c = LetraIMayus, c <= LetraFMayus){
		pangrama[c] = False;
	}
}

function contieneabc(frase: TipoFrase): bool
/*
 * Comprueba si una frase contiene
 * todas las letras del ABC
 */
	lascontiene: bool;
	arraypangrama: TipoPangrama;
	i: int;

{
	lascontiene = False;
	inicializarpangrama(arraypangrama);
	
	for(i = Neutro, i < frase.ncaracts){
		switch(frase.caracts[i]){
		case LetraIMayus..LetraFMayus:
			arraypangrama[frase.caracts[i]] = True;
		default:
			;
		}
	}
	
	if(estruepangrama(arraypangrama)){
		lascontiene = True;
	}
	
	return lascontiene;
}

function espangrama(frase: TipoFrase): bool
{
	return contieneabc(frase);
}

procedure escribirfrasespangrama(texto: TipoTexto)
	i: int;
{
	for(i = Neutro, i < texto.nfrases){
		if(espangrama(texto.frases[i])){
			escribirfrase(texto.frases[i]);
		}
	}
}

function distancia(l1: char, l2: char): int
/* Calcula la distancia entre dos letras */
{
	if(l2 > l1){
		return int(l2) - int(l1);
	}else{
		return int(l1) - int(l2);
	}
}

procedure pasarmayusletra(ref l: char)
{
	l = char(int(LetraIMayus) + distancia(LetraIMinus, l));
}

procedure pasarmayusletras(ref frase: TipoFrase)
	i: int;
{
	for(i = Neutro, i < frase.ncaracts){
		switch(frase.caracts[i]){
		case LetraIMinus..LetraFMinus:
			pasarmayusletra(frase.caracts[i]);
		default:
			;
		}
	}
}

procedure pasarmayusfrases(ref texto: TipoTexto)
	i: int;
{
	for(i = Neutro, i < texto.nfrases){
		pasarmayusletras(texto.frases[i]);
	}
}

procedure leercaract(ref fichero: file, ref frase: TipoFrase)
	c: char;
{
	fread(fichero, c);
	frase.caracts[frase.ncaracts] = c;
}

function escaract(c: char): bool
{
	return c != Eol and c != Eof;
}

procedure leerfrase(ref fichero: file, ref frase: TipoFrase)
	c: char;
{
	do{
		fpeek(fichero, c);
		if(escaract(c)){
			leercaract(fichero, frase);
			frase.ncaracts = frase.ncaracts + 1;
		}
	}while(escaract(c));		
}

procedure saltarlinea(ref fichero: file)
{
	freadeol(fichero);
}

procedure inicializarcaracts(ref caracts: TipoArrCaracts)
	i: int;
{
	for(i = Neutro, i < MaxNCaracts){
		caracts[i] = '@';
	}
}

procedure inicializarfrase(ref frase: TipoFrase)
{
	inicializarcaracts(frase.caracts);
	frase.ncaracts = Neutro;
}

procedure inicializarfrases(ref frases: TipoFrases)
	i: int;
{
	for(i = Neutro, i < MaxNFrases){
		inicializarfrase(frases[i]);
	}
}

procedure inicializartexto(ref texto: TipoTexto)
{
	inicializarfrases(texto.frases);
	texto.nfrases = Neutro;
}

procedure leertexto(ref fichero: file, ref texto: TipoTexto)
	c: char;
{
	inicializartexto(texto);
	do{
		fpeek(fichero, c);
		switch(c){
		case Eol:
			saltarlinea(fichero);
		case Eof:
			;
		default:
			leerfrase(fichero, texto.frases[texto.nfrases]);
			texto.nfrases = texto.nfrases + 1;
		}
	}while(c != Eof);
}

procedure main()
	fichero: file;
	texto: TipoTexto;
{
	open(fichero, "datos.txt", "r");
	leertexto(fichero, texto);
	close(fichero);
	pasarmayusfrases(texto);
	escribirfrasespangrama(texto);
}
