class ZCX_DATE_CONV_INVALID_FORMAT definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of ZCX_DATE_CONV_INVALID_FORMAT,
      msgid type symsgid value 'ZMC_DATE_CONVERSIONS',
      msgno type symsgno value '002',
      attr1 type scx_attrname value 'DATE_FORMAT',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_DATE_CONV_INVALID_FORMAT .
  interface ZIF_DATE_CONVERSIONS load .
  data DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_DATE_CONV_INVALID_FORMAT IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->DATE_FORMAT = DATE_FORMAT .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_DATE_CONV_INVALID_FORMAT .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
