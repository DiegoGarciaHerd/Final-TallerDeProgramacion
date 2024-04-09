{2.- Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la información de los autos en venta.
Implementar un programa que:
a)	Genere un árbol binario de búsqueda ordenado por patente identificatoria del auto en venta.
 Cada nodo del árbol debe contener patente, año de fabricación (2010..2018), la marca y el modelo.
b)	Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca que posee 
la agencia. Mostrar el resultado. 
c)	Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos agrupados
 por año de fabricación.
d)	Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con dicha 
patente. Mostrar el resultado. 
}

program ej2;

type 
    s_anio:2010..2018;
    auto_a=record
        patente:string;
        anio:s_anio;
        marca:string;
        modelo:string;
    end;
    
    auto_v=record
        patente:string;
        marca:string;
        modelo:string;
    end;

    lista=^nodo;
    nodo=record 
        dato:auto_v;
        sig:lista;
    end;

    arbol=^raiz 
    raiz=record 
        dato:auto;
        hi:arbol;
        hd:arbol;
    end;

    lista=^nodo;
    nodo=record

procedure leerAuto(var a:auto_a);
begin 
    write('PATENTE DEL AUTO: '); Readln(a.patente);
    write('ANIO DEL AUTO: '); readln(a.anio);
    write('MARCA DEL AUTO: '); Readln(a.marca);
    write('MODELO DEL AUTO: '); Readln(a.modelo);
end;

procedure crearArbol(var a:arbol; dato:auto_a);
begin
    if(a=nil)then begin
        new(a);
        a^.dato:=dato;
        a^.hi:=nil;
        a^.hd:=nil;
    end 
    else begin  
        if(a^.dato.patente>dato.patente)then 
            crearArbol(a^.hi,dato)
        else
            crearArbol(a^.hd,dato);
    end
end;

procedure cargarArbol(var a:arbol);
var 
    dato:auto_a;
begin   
    leerAuto(dato);
    while(dato.patente<>'ZZZ')do begin
        crearArbol(a,dato);
        leerAuto(dato);
    end;
end;


{b)	Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca que posee 
la agencia. Mostrar el resultado. }

function contarCantidad(a:arbol; marca:string):integer;
var 
    cant:Integer;
begin 
    cant:=0;
    if(a<>nil)then begin 
         cant:=contarCantidad(a^.hi,marca) + contarCantidad(a^.hd);
            if(a^.dato.marca = marca)then 
                cant:=cant+1;
    end;
    contarCantidad:=cant;
end;

{c)	Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos agrupados
 por año de fabricación.}

procedure autosAgrupados(var v:vector; a:arbol);
var 
    aux:auto_v;
begin 
    if(a<>nil)then begin 
        autosAgrupados(a^.hi);
        aux.patente:=a^.dato.patente;
        aux.marca:=a^.dato.marca;
        aux.modelo:=a^.dato.modelo;
        agregarAtras(v[a^.dato.anio],aux);
        autosAgrupados(a^.hd);
    end;
end;

function fabricacion(patente : str32; a : arbol) : s_anio;
begin
	if(a <> nil) then
	begin
		if(patente < a^.dato.patente) then
			fabricacion := fabricacion(patente, a^.izq)
		else if(patente > a^.dato.patente) then
			fabricacion := fabricacion(patente, a^.der)
		else
			fabricacion := a^.dato.anio;
	end
	else
	begin
		fabricacion := 2010;
	end;
end;