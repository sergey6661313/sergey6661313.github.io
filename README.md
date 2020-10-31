```javascript
# ScalpiLang (31.10.2020)  
 
Новый язык програмирования.
  статус: "hand made" - пустой фаил запускается.
  задача компилятора: переводить код с языка ScalpiLang в язык ассемблера fasmg.
  примечания: 
    по умолчанию компилируется фаил "examples\12_message_box.txt"

Приемущества относительно языка си:
  • есть операция взятия остатка '/ которая не генерирует код деления. 
  • глобальные и локальные переменные точно определены командами val и var  
  • нет путаници с указателями и знаком умножения.
    Все переменные ВСЕГДА рассматриваются как обозначение адресса в памяти. 
    'my_variable  - взятие значения переменной.
    ''my_variable - взятие значения по указателю.
  • многострочный текст c возможностю указания кодировки
    [UTF_8] text
      пример
      многострочного
      текста
  • однозначность действия скобочек - изменеие приоритета.
    для вызова функции используются оператор "->"
    для указания типа используются квадратные скобки, а не круглые
    при этом указание типо показывает компилятору как хранить числа
    и как проводить с ними действия, но не вкоем случае не заставлет компилятор
    как либо конвертировать числа.
      
```
