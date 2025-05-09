class ZCX_AMOUNT_SEPARATORS definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of DECIMAL_BEFORE_THOUSANDS,
      msgid type symsgid value 'ZMC_AMOUNT_SEPARATOR',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'AMOUNT_STRING',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of DECIMAL_BEFORE_THOUSANDS .
  constants:
    begin of THOUSANDS_ERROR,
      msgid type symsgid value 'ZMC_AMOUNT_SEPARATOR',
      msgno type symsgno value '001',
      attr1 type scx_attrname value 'AMOUNT_STRING',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of THOUSANDS_ERROR .
  constants:
    begin of MANY_DECIMAL_SEPARATORS,
      msgid type symsgid value 'ZMC_AMOUNT_SEPARATOR',
      msgno type symsgno value '002',
      attr1 type scx_attrname value 'AMOUNT_STRING',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of MANY_DECIMAL_SEPARATORS .
  constants:
    begin of SAME_SEPARATORS,
      msgid type symsgid value 'ZMC_AMOUNT_SEPARATOR',
      msgno type symsgno value '003',
      attr1 type scx_attrname value 'DECIMAL_SEPARATOR',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of SAME_SEPARATORS .
  data AMOUNT_STRING type STRING read-only .
  data DECIMAL_SEPARATOR type CHAR1 read-only .
  data THOUSANDS_SEPARATOR type CHAR1 read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !AMOUNT_STRING type STRING optional
      !DECIMAL_SEPARATOR type CHAR1 optional
      !THOUSANDS_SEPARATOR type CHAR1 optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_AMOUNT_SEPARATORS IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->AMOUNT_STRING = AMOUNT_STRING .
me->DECIMAL_SEPARATOR = DECIMAL_SEPARATOR .
me->THOUSANDS_SEPARATOR = THOUSANDS_SEPARATOR .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
