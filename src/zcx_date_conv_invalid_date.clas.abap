class ZCX_DATE_CONV_INVALID_DATE definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of ZCX_DATE_CONV_INVALID_DATE,
      msgid type symsgid value 'ZMC_DATE_CONVERSIONS',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'INVALID_DATE',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_DATE_CONV_INVALID_DATE .
  data INVALID_DATE type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !INVALID_DATE type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_DATE_CONV_INVALID_DATE IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->INVALID_DATE = INVALID_DATE .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_DATE_CONV_INVALID_DATE .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
