class ZCX_CUST_CONV_UNSUPPORTED_TYPE definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of ZCX_CUST_CONV_UNSUPPORTED_TYPE,
      msgid type symsgid value 'ZMC_CUSTOM_CONVER',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'TYPEKIND',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of ZCX_CUST_CONV_UNSUPPORTED_TYPE .
  type-pools ABAP .
  data TYPEKIND type ABAP_TYPEKIND read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !TYPEKIND type ABAP_TYPEKIND optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_CUST_CONV_UNSUPPORTED_TYPE IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->TYPEKIND = TYPEKIND .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = ZCX_CUST_CONV_UNSUPPORTED_TYPE .
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
