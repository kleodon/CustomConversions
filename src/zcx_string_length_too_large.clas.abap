class ZCX_STRING_LENGTH_TOO_LARGE definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of STRING_LENGTH_GT_EXPECTED,
      msgid type symsgid value 'ZMC_STR_LEN_TOO_LARG',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'STRING_LENGTH',
      attr2 type scx_attrname value 'MAX_EXPECTED_LENGTH',
      attr3 type scx_attrname value 'STRING',
      attr4 type scx_attrname value '',
    end of STRING_LENGTH_GT_EXPECTED .
  data STRING type STRING read-only .
  data STRING_LENGTH_I type I read-only .
  data MAX_EXPECTED_LENGTH_I type I read-only .
  data STRING_LENGTH type STRING .
  data MAX_EXPECTED_LENGTH type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !STRING type STRING optional
      !STRING_LENGTH_I type I optional
      !MAX_EXPECTED_LENGTH_I type I optional
      !STRING_LENGTH type STRING optional
      !MAX_EXPECTED_LENGTH type STRING optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_STRING_LENGTH_TOO_LARGE IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->STRING = STRING .
me->STRING_LENGTH_I = STRING_LENGTH_I .
me->MAX_EXPECTED_LENGTH_I = MAX_EXPECTED_LENGTH_I .
me->STRING_LENGTH = STRING_LENGTH .
me->MAX_EXPECTED_LENGTH = MAX_EXPECTED_LENGTH .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
