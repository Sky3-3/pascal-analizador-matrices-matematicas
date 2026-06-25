# Pascal: Analizador Estadístico y Calculador de Matrices Numéricas con Verificación de Primos

Este repositorio contiene un proyecto práctico de escritorio desarrollado en **Pascal** utilizando el entorno **Lazarus / Delphi** enfocado en la manipulación avanzada de estructuras bidimensionales dinámicas y la implementación de lógica matemática/aritmética discreta. La aplicación inicializa una matriz de enteros basada en dimensiones ingresadas por el usuario, inyecta valores pseudoaleatorios (0 a 999) renderizados sobre un componente `TStringGrid` y despliega un panel de control interactivo para calcular extremos (mínimos/máximos), paridad, sumas vectoriales indexadas y almacenamiento de números primos en colecciones lineales secundarias.

---

## 📊 Interfaz Gráfica del Sistema

Para que el diseño de tu panel con los 6 botones de control matemático se previsualice en la portada de tu portafolio, guarda tu captura de pantalla en la raíz con el nombre exacto de `interfaz_matematica.png`:

![Interfaz de Lazarus - Analizador Numérico](interfaz_matematica.png)

---

## ⚙️ Componentes y Algoritmos de Control Core

El código fuente en `src/Unit1.pas` destaca por el uso eficiente de la memoria y el procesamiento lógico iterativo:

### 1. Motor Dinámico de Inicialización (`btn_datosClick`)
A diferencia de estructuras estáticas rígidas, el procedimiento captura las dimensiones deseadas por el usuario a través de objetos `TEdit` y ajusta el tamaño del componente visual en tiempo de ejecución:
```pascal
fi := strtoint(edt_fil.text);
co := strtoint(edt_col.text);

grid_num.RowCount := fi;
grid_num.ColCount := co;

```

### 2. Algoritmo de Verificación de Números Primos (`btn_primosClick`)

El módulo procesa cada elemento de la matriz mediante bucles anidados. Excluye valores menores o iguales a 1 y evalúa la divisibilidad a través de un ciclo de fuerza bruta optimizado con una bandera booleana y una sentencia de interrupción inmediata (`break`):

```pascal
if valor > 1 then
begin
  es_primo := true; 
  for i := 2 to valor - 1 do
  begin
    if (valor mod i = 0) then
    begin
      es_primo := false; // Encontró un divisor intermedio, se anula la condición
      break;             // Interrupción de optimización de ciclos de CPU
    end;
  end;
  
  if es_primo then
  begin
    arreglo_primos[cant_primos] := valor; // Inyección en el arreglo estático de respaldo
    cant_primos := cant_primos + 1;
  end;
end;

```

### 3. Acumuladores Vectoriales con Expansión Visual (`btn_sumaClick`)

Permite al usuario elegir una columna específica para sumar sus componentes de manera lineal. Al finalizar el cálculo, expande dinámicamente la cuadrícula añadiendo una nueva fila en el componente gráfico para estampar el total obtenido en la celda correspondiente:

```pascal
grid_num.RowCount := grid_num.RowCount + 1;
grid_num.cells[c_ele, fi] := inttostr(suma);

```

---

## 🛠️ Conceptos Técnicos Aplicados

* **Redimensionamiento Dinámico de GUI**: Manipulación en tiempo de ejecución de las propiedades estructurales (`RowCount` / `ColCount`) de objetos visuales basados en grids de datos para adaptarse a los flujos ingresados por el operador.
* **Arreglos de Respaldo e Inyección Lineal**: Uso de una estructura unidimensional secundaria (`arreglo_primos`) para aislar, almacenar y ordenar porciones específicas de datos filtradas de la matriz principal.
* **Control de Excepciones Lógicas**: Inicialización de búsquedas de mínimos absolutos asignando la primera posición real de la matriz (`menor := num[0, 0]`) en lugar de inicializar en cero, evitando sesgos lógicos comunes en matrices compuestas por enteros positivos.
* **Optimización de Bucles mediante Sentencias `break**`: Uso de interrupciones controladas sobre hilos iterativos para detener evaluaciones aritméticas redundantes una vez que se cumple la condición de descarte de un token.
