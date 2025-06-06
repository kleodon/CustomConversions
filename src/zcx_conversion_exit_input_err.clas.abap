class ZCX_CONVERSION_EXIT_INPUT_ERR definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  data MESSAGE_TYPE type SYST_MSGTY .
  data MESSAGE_NUMBER type SYST_MSGNO .
  data MESSAGE_ID type SYST_MSGID .
  data MESSAGE_VARIABLE_1 type SYST_MSGV .
  data MESSAGE_VARIABLE_2 type SYST_MSGV .
  data MESSAGE_VARIABLE_3 type SYST_MSGV .
  data MESSAGE_VARIABLE_4 type SYST_MSGV .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MESSAGE_TYPE type SYST_MSGTY optional
      !MESSAGE_NUMBER type SYST_MSGNO optional
      !MESSAGE_ID type SYST_MSGID optional
      !MESSAGE_VARIABLE_1 type SYST_MSGV optional
      !MESSAGE_VARIABLE_2 type SYST_MSGV optional
      !MESSAGE_VARIABLE_3 type SYST_MSGV optional
      !MESSAGE_VARIABLE_4 type SYST_MSGV optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_CONVERSION_EXIT_INPUT_ERR IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->MESSAGE_TYPE = MESSAGE_TYPE .
me->MESSAGE_NUMBER = MESSAGE_NUMBER .
me->MESSAGE_ID = MESSAGE_ID .
me->MESSAGE_VARIABLE_1 = MESSAGE_VARIABLE_1 .
me->MESSAGE_VARIABLE_2 = MESSAGE_VARIABLE_2 .
me->MESSAGE_VARIABLE_3 = MESSAGE_VARIABLE_3 .
me->MESSAGE_VARIABLE_4 = MESSAGE_VARIABLE_4 .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
