program casillas;

procedure escribecoord8(c: char, f: int)
{
	write(succ(c));
	write(succ(f));
}

procedure escribecoord7(c: char, f: int)
{
	write(succ(c));
	write(f);
}

procedure escribecoord6(c: char, f: int)
{
	write(succ(c));
	write(pred(f));
}

procedure escribecoord5(c: char, f: int)
{
	write(c);
	write(succ(f));
}

procedure escribecoord4(c: char, f: int)
{
	write(c);
	write(pred(f));
}

procedure escribecoord3(c: char, f: int)
{
	write(pred(c));
	write(succ(f));
}

procedure escribecoord2(c: char, f: int)
{
	write(pred(c));
	write(f);
}

procedure escribecoord1(c: char, f: int)
{
	write(pred(c));
	write(pred(f));
}

procedure imprimcoordadya(c: char, f: int)
{
	escribecoord1(c, f);
	write(" ");
	escribecoord2(c, f);
	write(" ");
	escribecoord3(c, f);
	write(" ");
	escribecoord4(c, f);
	write(" ");
	escribecoord5(c, f);
	write(" ");
	escribecoord6(c, f);
	write(" ");
	escribecoord7(c, f);
	write(" ");
	escribecoord8(c, f);
	writeeol();
}

procedure intercambiar(ref c1: char, ref f1: int, ref c2: char, ref f2: int)
	aux1: char;
	aux2: int;
{
	aux1 = c1;
	aux2 = f1;
	c1 = c2;
	f1 = f2;
	c2 = aux1;
	f2 = aux2;
}

function esmenorcoord2(c1: char, f1: int, c2: char, f2: int): bool
{
	return (f2 < f1) or ( (f2 == f1) and (c2 < c1) );
}

procedure ordenarcoord(ref c1: char, ref f1: int, ref c2: char, ref f2: int)
{
	if(esmenorcoord2(c1, f1, c2, f2)){
		intercambiar(c1, f1, c2, f2);
	}
}

procedure leercoord(ref c: char, ref f: int)
{
	readln(c);
	readln(f);
}

procedure main()
	columna1: char;
	fila1: int;
	columna2: char;
	fila2: int;
{
		leercoord(columna1, fila1);
		leercoord(columna2, fila2);
		ordenarcoord(columna1, fila1, columna2, fila2);
		imprimcoordadya(columna1, fila1);
}
