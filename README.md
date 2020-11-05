```javascript
# ScalpiLang (04.11.2020)  
 
Новый язык програмирования.

Разница по отношениею к языку Си:
  + нет путаници с указателями и знаком умножения.
    Все переменные ВСЕГДА рассматриваются как обозначение адресса в памяти. 
    'my_variable  - взятие значения переменной.
    ''my_variable - взятие значения от значения взятого по адрессу равнозначто взятию по указателю.
    
  + есть операция взятия остатка '/ которая не генерирует код деления.
    если во время деления процессор всё равно высчитыает остаток так зачем его высчитывать 2 раза??
  
  + глобальные и локальные переменные точно определены командами val и var  
    val - глобальная переменная (значения прямо вписаны в фаил)
    var - локальная переменная (значение бдет храниться в стеке во время исполнения программы)
    
  + многострочный текст без лишних символов определяется тупо отступом.
    text
      пример
      многострочного
      текста
      
  + возможность указания кодировки
    [UTF_8] text "однострочный текст"
  
  + однозначность действия скобочек - изменеие приоритета.
    для вызова функции используются оператор "->"
    для указания типа используются квадратные скобки, а не круглые
    при этом указание типо показывает компилятору как хранить числа
    и как проводить с ними действия, но не вкоем случае не заставлет компилятор
    как либо конвертировать числа.
   
  - Нет готового компилятора (пока что)
    Статус разработки компилятора:
      задача компилятора: переводить код с языка ScalpiLang в язык ассемблера fasmg.

      check points:
        [X] читать фаил
        [ ] компилировать
            [?] разбить на строки
            [ ] создать код для каждой строки
        [ ] сохранить



Спецификация:
 '   - взять значение по адрессу (имеет больший приоритет чем математика)
 var - задать локальную переменную
 val - задать глобальную переменную
 fn  - обьявление функции
 
     
примечания: 
  Если фаил не указать скомпилируется "examples\12_message_box.txt"
  всем переменным добавляется "_" чтобы гарантировать что они не совпадут с директивами fasmg
 
```
