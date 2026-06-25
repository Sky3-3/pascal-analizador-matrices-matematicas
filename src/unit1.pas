unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btn_datos: TButton;
    btn_mayval: TButton;
    btn_menval: TButton;
    btn_numpar: TButton;
    btn_suma: TButton;
    btn_primos: TButton;
    edt_col: TEdit;
    edt_fil: TEdit;
    grid_num: TStringGrid;
    lbl_col: TLabel;
    lbl_primos: TLabel;
    lbl_fil: TLabel;
    procedure btn_datosClick(Sender: TObject);
    procedure btn_mayvalClick(Sender: TObject);
    procedure btn_menvalClick(Sender: TObject);
    procedure btn_numparClick(Sender: TObject);
    procedure btn_primosClick(Sender: TObject);
    procedure btn_sumaClick(Sender: TObject);
  private

  public

  end;

const
     fil=15;
     col=15;

var
  Form1: TForm1;
  fi,co:integer;
  num:array [0..fil, 0..col] of integer;

  arreglo_primos: array [0..100] of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btn_datosClick(Sender: TObject);
var
   f,c:integer;
   nums:integer;
begin
     randomize;
     fi:=strtoint(edt_fil.text);
     co:=strtoint(edt_col.text);

     grid_num.RowCount:=fi;
     grid_num.ColCount:=co;

     for f:=0 to fi-1 do
     begin
          for c:=0 to co-1 do
          begin
               nums:=random(1000);
               num[f,c]:=nums;
               grid_num.cells[c,f]:=inttostr(num[f,c]);
          end;
     end;

     btn_datos.enabled:=false;
     btn_mayval.enabled:=true;
     btn_menval.enabled:=true;
     btn_numpar.enabled:=true;
     btn_suma.enabled:=true;
     btn_primos.enabled:=true;

end;

procedure TForm1.btn_mayvalClick(Sender: TObject);
var
   f,c:integer;
   mayor:integer;
   pos_fc:string;
begin
     mayor:=0;

     for f:=0 to fi-1 do
     begin
          for c:=0 to co-1 do
          begin
               if num[f,c]>mayor then
               begin
                    mayor:=num[f,c];
                    pos_fc:='[' + inttostr(f) + ';' + inttostr(c) + ']';
               end;
          end;
     end;

     showmessage('El numero mas grande es ' + inttostr(mayor) +
                 ', y se encuentra en la posicion ' + pos_fc);
end;

procedure TForm1.btn_menvalClick(Sender: TObject);
var
   f,c:integer;
   menor:integer;
   pos_fc:string;
begin
     menor:= num[0, 0];
     pos_fc:= '[0;0]';

     for f:=0 to fi-1 do
     begin
          for c:=0 to co-1 do
          begin
               if num[f, c] < menor then
               begin
                    menor:=num[f,c];
                    pos_fc:='[' + inttostr(f) + ';' + inttostr(c) + ']';
               end;
          end;
     end;

     showmessage('El numero mas pequeño es el ' + inttostr(menor) +
                 ', y se encuentra en la posicion ' + pos_fc);
end;

procedure TForm1.btn_numparClick(Sender: TObject);
var
   f,c,pares:integer;
begin
     pares:= 0;

     for f:=0 to fi-1 do
     begin
          for c:=0 to co-1 do
          begin
               if num[f, c] mod 2 = 0 then
                  pares:=pares+1;
          end;
     end;

     showmessage('La cantidad de numeros pares es de ' + inttostr(pares)
                 + ' pares');
end;

procedure TForm1.btn_primosClick(Sender: TObject);
var
   f, c, i, valor, cant_primos: integer;
   es_primo: boolean;
   texto_final: string;
begin
     // 1. Arrancamos el contador de primos encontrados en 0
     cant_primos := 0;

     // 2. Recorremos la matriz fila por fila y columna por columna
     for f := 0 to fil - 1 do
     begin
          for c := 0 to col - 1 do
          begin
               valor := num[f, c]; // Agarramos el número de la celda actual

               // El 0 y el 1 NO son primos. Solo probamos los mayores a 1
               if valor > 1 then
               begin
                    es_primo := true; // Sospechamos que es primo

                    // Probamos si algún número entre el 2 y el anterior lo divide justo
                    for i := 2 to valor - 1 do
                    begin
                         if (valor mod i = 0) then
                         begin
                              es_primo := false; // Encontró otro divisor, NO es primo
                              break;             // Rompemos el bucle para ahorrar tiempo
                         end;
                    end;

                    // 3. ¡SI PASÓ LA PRUEBA! Lo guardamos en nuestro arreglo
                    if es_primo then
                    begin
                         arreglo_primos[cant_primos] := valor; // Lo metemos en la bolsa
                         cant_primos := cant_primos + 1;       // Avanzamos el casillero
                    end;
               end;
          end;
     end;

     // 4. CONTROL DE ERRORES / MOSTRAR RESULTADOS (Punto c del enunciado)
     if cant_primos = 0 then
     begin
          // Si el contador quedó en cero, ponemos el cartel obligatorio que te pide la profe
          lbl_primos.Caption := 'Números primos encontrados: La matriz no tiene números primos';
     end
     else
     begin
          // Si encontramos primos, armamos el texto usando un FOR para recorrer nuestro arreglo
          texto_final := 'Números primos encontrados: ';

          for i := 0 to cant_primos - 1 do
          begin
               if i = 0 then
                    texto_final := texto_final + inttostr(arreglo_primos[i])
               else
                    texto_final := texto_final + ', ' + inttostr(arreglo_primos[i]);
          end;

          // Volcamos toda la lista de números en tu TLabel
          lbl_primos.Caption := texto_final;
     end;
end;

procedure TForm1.btn_sumaClick(Sender: TObject);
var
   c_ele,suma,f:integer;
begin
     c_ele:=strtoint(inputbox('Elige un numero', 'Elige la columna que sumaras', ''));
     suma:=0;

     for f:=0 to fi-1 do
     begin
          suma:=suma+num[f,c_ele];
     end;

     grid_num.RowCount:=grid_num.RowCount+1;

     grid_num.cells[c_ele,fi]:=inttostr(suma);
end;


end.
