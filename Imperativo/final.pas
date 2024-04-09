program final;

type 
    alumno=record 
      nombre:string;
      legajo:integer;
      cantidad:integer;
    end;

    arbol=^raiz;
    raiz=record 
        dato:alumno;
        hi:arbol;
        hd:arbol;
    end;

    lista=^nodo;
    nodo=record
        dato:alumno;
        sig:lista;
    end;
procedure leerAlumno(var a:alumno);
begin 
    write('NOMBRE DE ALUMNO: '); readln(a.nombre);
    write('NUMERO DE LEGAJO: '); readln(a.legajo);
    write('CANTIDAD DE AUTOEVALUACIONES APROBADAS: '); readln(a.cantidad);
end;

procedure crearArbol(var a:arbol; alu:alumno);
begin   
    if(a=nil)then begin 
        new(a);
        a^.dato:=alu;
        a^.hi:=nil;
        a^.hd:=nil;
    end 
    else begin
        if(a^.dato.legajo > alu.legajo)then 
            crearArbol(a^.hi,alu)
        else 
            crearArbol(a^.hd,alu);
    end;
end;

procedure registrarAlumnos(var a:arbol);
var 
    alu:alumno;
begin
    leerAlumno(alu);
    while(alu.legajo<>0)do begin 
        crearArbol(a,alu);
        leerAlumno(alu);
    end;
end;

procedure incrementar(var a:arbol; legajo:integer);
begin 
    if(a<>nil)then begin 
        if(a^.dato.legajo = legajo)then 
            a^.dato.cantidad:=a^.dato.cantidad + 1
        else begin  
            if(a^.dato.legajo > legajo)then 
                incrementar(a^.hi,legajo)
            else 
                incrementar(a^.hd,legajo);
        end;
    end;
end;

procedure insertarOrdenado(var l:lista; alu:alumno);
var 
    ant,act,aux:lista;
begin 
    new(aux);
    aux^.dato:=alu;
    act:=l;
    ant:=l;
    while(act<>nil)and(act^.dato.nombre < alu.nombre)do begin 
        ant:=act;
        act:=act^.sig;
    end;
    if(act=ant)then 
        l:=aux
    else 
        ant^.sig:=aux;
    aux^.sig:=act;
end;

procedure listaOrdenada(var a:arbol; var l:lista);
begin 
    if(a<>nil)then begin 
        listaOrdenada(a^.hi,l);
        if(a^.dato.cantidad >= 3)then 
          insertarOrdenado(l,a^.dato);
        listaOrdenada(a^.hd,l);
    end;
end;

procedure imprimirAlumno(a:alumno);
begin 
    writeln('-------------------------------');
    write('NOMBRE ALUMNO: '); writeln(a.nombre);
    write('LEGAJO: '); writeln(a.legajo);
    write('CANTIDAD DE AUTOEVALUACIONES APROBADAS: '); writeln(a.cantidad);
    writeln('-------------------------------');
end;

procedure imprimirArbol(a:arbol);
begin 
    writeln('IMPRIMIENDO ARBOL...');
    if(a<>nil)then begin 
        imprimirArbol(a^.hi);
        imprimirAlumno(a^.dato);
        imprimirArbol(a^.hd);
    end;
end;

procedure imprimirLista(l:lista);
begin 
    writeln('IMPRIMIENDO LISTA...');
    while(l<>nil)do begin 
        imprimirAlumno(l^.dato);
        l:=l^.sig;
    end;
end;

var
    a:arbol; l:lista;
begin
    a:=nil;
    l:=nil;
    registrarAlumnos(a);
    imprimirArbol(a);
    incrementar(a,314);
    imprimirArbol(a);
    listaOrdenada(a,l);
    imprimirLista(l);
end.