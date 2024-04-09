{1.	 Una biblioteca nos ha encargado procesar la información de los préstamos realizados durante cada el año 2021. 
De cada préstamo se conoce el ISBN del libro, el número de socio, día y mes del préstamo y cantidad de días prestados.
 Implementar un programa con:
a.	Un módulo que lea préstamos y retorne en una estructura adecuada la información de los préstamos organizada por mes. 
Para cada mes, los préstamos deben quedar ordenados por ISBN. La lectura de los préstamos finaliza con ISBN -1.
b.	Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes, ISBN y numero de socio.
c.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por ISBN.
d.	Un módulo recursivo que reciba la estructura generada en c. y muestre todos los ISBN y número de socio correspondiente.
e.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca 
una vez junto a la cantidad total de veces que se prestó durante el año 2021.
f.	Un módulo recursivo que reciba la estructura generada en e. y muestre su contenido.
}

program ej1;

type 
    prestamo=record 
        isbn:integer;
        nroSocio:integer;
        dia:integer;
        mes:integer;
    end;

    libro=record 
        isbn:integer;
        cant:integer;
    end;

    l_libros=^nodoL
    nodoL=record 
        dato:libro;
        sig:l_libros;
    end;
    lista=^nodo;
    nodo=record 
        dato:prestamo;
        sig:lista;
    end;

    vector=array[1..12]of lista;
{
a.	Un módulo que lea préstamos y retorne en una estructura adecuada la información de los préstamos organizada por mes. 
Para cada mes, los préstamos deben quedar ordenados por ISBN. La lectura de los préstamos finaliza con ISBN -1.
}
procedure leerPrestamo(var p:prestamo);
begin 
    write('ISBN: '); readln(p.isbn);
    write('NUMERO DE SOCIO: '); readln(p.nroSocio);
    write('DIA: '); readln(p.dia);
    write('MES: '); readln(p.mes);
end;

{procedure crearArbol(var l; p:prestamo);
begin 
    if(a=nil)then begin 
        new(a);
        a^.dato:=p;
        a^.hi:=nil;
        a^.hd:=nil;
    end 
    else begin 
        if(a^.dato.nroSocio > p.nroSocio)then 
            crearArbol(a^.hi,p)
        else 
            crearArbol(a^.hd,p);
    end;
end;}

procedure insertarOrdenado(var l:lista; p:prestamo);
var 
    aux,ant,act:lista;
begin 
    new(aux);
    aux^.dato:=p;
    act:=l;
    ant:=l;
    while(act<>nil)and(act^.dato.isbn > p.isbn)do begin 
        ant:=act;
        act:=act^.sig;
    end;
    if(act=ant)then 
        l:=aux;
    else 
        ant^.sig:=aux;
    aux^.sig:=act;
end;
    
procedure cargarLista(var v:vector);
var 
    p:prestamo;
begin
    leerPrestamo(p);
    while(p.isbn<>-1)do begin
        insertarOrdenado(v[p.mes],p);
        leerPrestamo(p);
    end;
end;

{b.	Un módulo recursivo que reciba la estructura generada en a. y muestre, para cada mes, ISBN y numero de socio.}


{c.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura con todos los préstamos ordenados por ISBN.}

procedure minimo(v:vector; var min:integer);
var 
    indice:integer;
begin 
    indice:=0;
    min:=99999;
    for i:1 to 12 do begin 
        if(v[i]<>nil)and(v[i]^.dato.isbn<min)then 
            min:=v[i]^.dato.isbn;
            indice:=i;
        end;
    end;

    if(min<>0)then 
        v[indice]:=v[indice]^.sig;
end;

procedure agregarAtras(var l:lista; p:prestamo);
var 
    act,aux:lista;
begin
    new(aux);
    aux^.dato:=p;
    aux^.sig:=nil;
    if(l=nil)then
        l:=aux;
    else begin 
        act:=l;
        while(act^.sig<>nil)do begin
            act:=act^.sig;
        act^.sig:=aux;
    end;
end;

procedure merge(var l:lista; v:vector);
var 
    min:integer;
begin 
    minimo(v,min);
    while(min<>99999)do begin 
        agregarAtras(l,min);
        minimo(v,min);
    end;
end;

{d.	Un módulo recursivo que reciba la estructura generada en c. y muestre todos los ISBN y número de socio correspondiente.}

{e.	Un módulo que reciba la estructura generada en a. y retorne una nueva estructura ordenada ISBN, donde cada ISBN aparezca 
una vez junto a la cantidad total de veces que se prestó durante el año 2021.}

procedure listaLibros(v:vector; var l:l_libros);
var 
    cant:integer; min:prestamo; actual:libro;
begin
    l:=nil;
    minimo(v,min);
    while(min<>99999)do begin
        actual:=min.isbn;
        actual.cant:=0;
        while(min<>99999)and(actual=min.isbn)do begin 
            actual.cant:=cant + 1;
            minimo(v,min);
        end;
        agregarAtras(v,actual);
    end;
end;

