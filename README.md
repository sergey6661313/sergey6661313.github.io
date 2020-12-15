```javascript
# ScalpiLang (19.11.2020)  
 
Новый язык програмирования.

Разница по отношениею к языку Си:
  + нет путаници с указателями и знаком умножения.
    Все переменные ВСЕГДА рассматриваются как обозначение смещения (относительно начала фаила, стека, адресса и пр.) в памяти. 
    my_variable'  - взятие значения переменной.
    my_variable'' - взятие значения от значения взятого по адрессу равнозначто взятию по указателю.
      
  + есть операция взятия остатка "%" которая не генерирует код деления.
    если во время деления процессор всё равно высчитыает остаток так зачем его высчитывать 2 раза??
  
  + глобальные и локальные переменные точно определены командами val и var  
    val - глобальная переменная (значения прямо вписаны в фаил)
    var - локальная переменная (значение бдет храниться в стеке во время исполнения программы)
    
  + многострочный текст без кавычек - определяется тупо отступом.
    text
      пример
      многострочного
      текста
      
  + возможность указания кодировки
    text [UTF_8] "однострочный текст"
  
  + однозначность действия скобочек - изменение приоритета. (компилятор тупо вырезает их из строки и записывает новой строкой выше компилируемой строки)
    для вызова функции используются оператор "->"
    для указания типа используются квадратные скобки, а не круглые.
    при этом типы можно указать в любой момент любому действию, переменной или числу.
    При этом тип используется исключительно для того чтобы компиятор знал какой регистр и какую команду использовать.
    Указание типа нивкоем случае не обозначает конвертирование числа.
  
  - Нет готового компилятора (пока что)
    Статус разработки компилятора:
      задача компилятора: переводить код с языка ScalpiLang в язык ассемблера fasmg.

      check points:
        [X] читать фаил
        [ ] компилировать
            [x] разбить на строки
            [ ] создать код для каждой строки
        [?] сохранить

 
     
примечания: 
  всем переменным добавляется "_" чтобы гарантировать что они не совпадут с директивами fasmg
 
```
