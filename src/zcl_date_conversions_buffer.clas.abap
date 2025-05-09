class ZCL_DATE_CONVERSIONS_BUFFER definition
  public
  final
  create private .

public section.

  interfaces ZIF_DATE_CONVERSIONS .

  class-methods GET_OBJECT
    returning
      value(RO_OBJECT) type ref to ZCL_DATE_CONVERSIONS_BUFFER .
  class-methods FREE_OBJECT .
  methods SET_REGEX
    importing
      !REGEX type ref to CL_ABAP_REGEX .
  methods SET_DATE_FORMAT
    importing
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT .
  methods SET_DATE_SEQUENCE
    importing
      !DATE_SEQUENCE type ZIF_DATE_CONVERSIONS=>TY_DATE_SEQUENCE .
  methods GET_REGEX
    returning
      value(RO_REGEX) type ref to CL_ABAP_REGEX .
  methods GET_DATE_FORMAT
    returning
      value(RV_DATE_FORMAT) type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT .
  methods GET_DATE_SEQUENCE
    returning
      value(RV_DATE_SEQUENCE) type ZIF_DATE_CONVERSIONS=>TY_DATE_SEQUENCE .
protected section.
private section.

  class-data O_SINGLETON type ref to ZCL_DATE_CONVERSIONS_BUFFER .
  data REGEX type ref to CL_ABAP_REGEX .
  data DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT .
  data DATE_SEQUENCE type ZIF_DATE_CONVERSIONS=>TY_DATE_SEQUENCE .
ENDCLASS.



CLASS ZCL_DATE_CONVERSIONS_BUFFER IMPLEMENTATION.


  METHOD free_object.
    CLEAR zcl_date_conversions_buffer=>o_singleton->date_format.
    CLEAR zcl_date_conversions_buffer=>o_singleton->date_sequence.
    FREE zcl_date_conversions_buffer=>o_singleton->regex.
    FREE zcl_date_conversions_buffer=>o_singleton.
  ENDMETHOD.


  METHOD get_date_format.
    rv_date_format = me->date_format.
  ENDMETHOD.


  METHOD get_date_sequence.
    rv_date_sequence = me->date_sequence.
  ENDMETHOD.


  METHOD get_object.
    IF zcl_date_conversions_buffer=>o_singleton IS NOT BOUND.
      zcl_date_conversions_buffer=>o_singleton = NEW zcl_date_conversions_buffer( ).
    ENDIF.
*
    ro_object = zcl_date_conversions_buffer=>o_singleton .
  ENDMETHOD.


  METHOD get_regex.
    ro_regex = me->regex.
  ENDMETHOD.


  method SET_DATE_FORMAT.
    me->date_format = date_format.
  endmethod.


  METHOD set_date_sequence.
    me->date_sequence = date_sequence.
  ENDMETHOD.


  METHOD set_regex.
    me->regex = regex.
  ENDMETHOD.
ENDCLASS.
