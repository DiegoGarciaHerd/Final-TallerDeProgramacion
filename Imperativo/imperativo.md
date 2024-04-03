<h1 align="center">IMPERATIVO</h1>

---

## Indice
* [Ordenacion](#Ordenacion)
* [Arboles](#Arboles)

Ordenacion 
=== 
---
## Seleccion
```pascal
procedure ordenarSeleccion(var v:vector; diml:integer);
var 
    i,j,p:integer; item:venta;
begin 
    for i:=1 to diml-1 do begin 
        p:=i;
        for j:=i+1 to diml do 
            if(v[p].cod>v[j].cod)then 
                p:=j;
        item:=v[p];
        v[p]:=v[i];
        v[i]:=item;
    end;
end;
```
- Tiempo de ejecucion = N^2

## Inserción
```pascal
procedure ordenarInsercion(var v:vector; diml:integer);
var 
    i,j,p:integer; actual:venta;
begin  
    for i:=2 to diml-1
        actual:=v[i];
        p:=i-1;
        while(j>0)and(v[j].codId>actual.codId)do begin 
            v[j+1]:=v[j];
            j:=j-1;
        end;
        v[j+1]:=v[j];
    end;
end;
```
- Tiempo de ejecución= N^2
- Si los datos estan ordenados de menor a mayor, solo se haran comparaciones.

Arboles
===
---
- [Crear arbol](#Crear)
- [Imprimir](#Imprimir)
- [Buscar](#Buscar)
- [Minimo](#Minimo)
- [Maximo](#Maximo)
- [Contar_Elementos](#ContarElementos)
- [Contar_Elementos_entre_un_rango](#Entre_rango)


Crear 
=== 
```pascal
procedure crear (var a:arbol; num:integer);
Begin
    if (a=nil) then
    begin
        new(a);
        a^.HI:= nil; 
        a^.HD:= nil;
        a^.dato:= num; 
    end
    else
        if (num < a^.dato) then 
            crear(a^.HI,num)
        else 
            crear(a^.HD,num)   
end;
```
Imprimir
===
## En orden
```pascal 
procedure enOrden(a:arbol);
begin
    if(a<>nil)then begin
        enOrden(a^.hi);
        write(a^.dato);
        enOrden(a^.hd);
    end;
end;
```

## PreOrden
```pascal
procedure preOrden(a:arbol);
begin
    if(a<>nil)then begin
        write(a^.dato);
        preOrden(a^.hi);
        preOrden(a^.hd);
    end;
end;
```

## PosOrden
```pascal
procedure posOrden(a:arbol);
begin
    if(a<>nil)then begin
        posOrden(a^.hi);
        posOrden(a^.hd);
        write(a^.dato);
    end;
end;
```

Buscar
===
```pascal
function buscar(a:arbol; elemento:integer):arbol;
begin
    if(a=nil)then begin
        buscar:=nil;
    else begin
        if(a^.dato = elemento)then
            buscar:=a
        else begin 
            if(a^.dato < elemento)then
                buscar:=buscar(a^.hi,elemento)
            else
                buscar(a^.hd,elemeto);
        end;
    end;
end;
```

Minimo
===
```pascal
function minimo(a:arbol):arbol;
begin
    if(a=nil)then begin
        minimo:=nil;
    else
        if(a^.hi=nil)then 
            minimo:=a
        else
            minimo:=minimo(a^.hi);
end;
```
Maximo
===
```pascal
function maximo(a:arbol):arbol;
begin 
  if (a=nil) then
        maximo:=nil
    else
        if(a^.hi=nil) then
            maximo:=a
        else
            maximo:=maximo(a^.hd);
end;
```
Contar_Elementos
```pascal
function contarElementos(a:arbol):integer;
var 
    cant:integer;
begin
    cant:=0;
    if(a<>nil)then 
        cant:=cant+1;
        contarElementos:=cant + contarElementos(a^.hi);
        contarElementos:=cant + contarElementos(a^.hd);
    end;
    contarElementos:=cant;
end;
```
Entre_rango 
===
---
## Imprimir
```pascal
procedure entreRango(a:arbol; inicio,fin:integer);
begin
    if(a<>nil)then begin
       if(a^.dato > inicio)and(a^.dato <fin)then begin 
            entreRango(a^.hi,inicio,fin);
            write(a^.dato);
            entreRango(a^.hd,inicio,fin);
        end
        else 
            if(a^.dato < inicio)then
                entreRango(a^.hd,inicio,fin)
            else
                if(a^.dato > fin)then
                    entreRango(a^.hi,fin);

    end;
end;
```
## Contar Elementos
```pascal
function entreRango(a:arbol,inicio,fin):integer;
var
    cant:integer;
begin 
    cant:=0;
    if(a<>nil)then begin
        if(a^.dato < inicio)then
            cant:=entreRango(a^.hd,inicio,fin)
        else
            if(a^.dato > fin)then
                cant:=entreRango(a^.hi,inicio,fin);
        else begin  
            cant:=cant+1;
            cant:=cant + entreRango(a^.hi,inicio,fin);
            cant:=cant + entreRango(a^.hd,inicio,fin);
        end;
    end;
    entreRango:=cant;
end;
```
