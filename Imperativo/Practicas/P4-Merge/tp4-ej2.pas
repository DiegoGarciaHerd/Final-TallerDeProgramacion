{2.	Un cine posee la lista de películas que proyectará durante el mes de octubre. De cada película se conoce: 
código de película, código de género(1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 
7: documental y 8: terror)
 y puntaje promedio otorgado por las críticas. Implementar un programa que contenga:
a.	Un módulo que lea los datos de películas y los almacene ordenados por código de película y agrupados por código de género,
 en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de película -1. 
b.	Un módulo que reciba la estructura generada en el punto a y retorne una estructura de datos donde estén todas las películas
 almacenadas ordenadas por código de película.
}

program ej2;

type 
    s_genero=1..8;
    pelicula=record 
        codPelicula:integer;
        codGenero:s_genero;
        puntaje:real;
    end;

    lista=^nodo;
    nodo=record
        dato:pelicula;
        sig:lista;
    end;
    vector=array[s_genero]of lista;

procedure leerPelicula(var p:pelicula);
begin 
    write('INGRESE CODIGO DE PELICULA: '); readln(p.codPelicula);
    write('INGRESE CODIGO DE GENERO(1..8): '); readln(p.codGenero);
    write('PUNTAJE: '); readln(p.puntaje);
end;

procedure cargarVector(var v:vector);
var 
    p:pelicula;
begin
    leerPelicula(p);
    while(p.codPelicula<>-1)do begin
        insertarOrdenado(v[p.codGenero],p);
        leerPelicula(p);
    end;
end;

procedure minimo(v:vector; min:pelicula);
var 
    i:integer;
    indice:integer;
begin 
    min.codPelicula:=99999;
    for i:=1 to 8 do begin 
        if(min.codPelicula>v[i]^.dato.codPelicula)then begin
            min:=v[i]^.dato;
            indice:=i;
        end;
    end;
    if(min.codPelicula<>99999)then 
        v[indice]:=v[indice]^.sig;
end;

procedure merge(v:vector; var l:lista);
var 
    min:pelicula;
begin 
    minimo(v,min);
    while(min.codPelicula<>99999)do begin
        agregarAtras(l,min);
        minimo(v,min);
    end;
end;