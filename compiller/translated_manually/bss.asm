;# ScalpiLang (02.11.2020)

;val[u8 512] text_command_line 
  label _text_command_line
  
  _text_command_line•__size = 512
  
  rb _text_command_line•__size



;val[u8 512] text_input_file_name 
  label _text_input_file_name
  
  _text_input_file_name•__size = 512
  
  rb _text_input_file_name•__size



;val[u8 1000] text_from_file
  label _text_from_file
  
  _text_from_file•__size = 1000
  
  rb _text_from_file•__size



;val lines_count
  label _lines_count
  rq 1



;val[t_slice 1000] lines
  label _lines
  _lines•__size = _t_slice•__size * 1000
  rb _lines•__size

