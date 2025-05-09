class ZCL_AMOUNT_CONVERSIONS definition
  public
  final
  create public .

public section.

  types:
    ty_abap_max_packed_number TYPE p LENGTH 16 DECIMALS 9 .
  types TY_DECIMAL_SEPARATOR type CHAR1 .
  types TY_THOUSANDS_SEPARATOR type CHAR1 .
  types TY_DECIMAL_PLACES type I .

  class-methods STRING_TO_AMOUNT
    importing
      !STRING type STRING
      !DECIMAL_SEPARATOR type TY_DECIMAL_SEPARATOR default '.'
      !THOUSANDS_SEPARATOR type TY_THOUSANDS_SEPARATOR default ''
    returning
      value(AMOUNT) type TY_ABAP_MAX_PACKED_NUMBER
    raising
      CX_CONVERSION_FAILED
      ZCX_AMOUNT_SEPARATORS .
  class-methods CHECK_SEPARATORS_IN_AMOUNT
    importing
      !STRING type STRING
      !DECIMAL_SEPARATOR type TY_DECIMAL_SEPARATOR
      !THOUSANDS_SEPARATOR type TY_THOUSANDS_SEPARATOR
    raising
      ZCX_AMOUNT_SEPARATORS .
  class-methods AMOUNT_TO_STRING
    importing
      !AMOUNT type TY_ABAP_MAX_PACKED_NUMBER
      !DECIMAL_SEPARATOR type TY_DECIMAL_SEPARATOR default '.'
      !THOUSANDS_SEPARATOR type TY_THOUSANDS_SEPARATOR default ''
      !DECIMAL_PLACES type TY_DECIMAL_PLACES default '2'
    returning
      value(STRING) type STRING
    raising
      ZCX_AMOUNT_SEPARATORS .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AMOUNT_CONVERSIONS IMPLEMENTATION.


  METHOD amount_to_string.
    DATA: lv_amount_reversed TYPE string.

    IF decimal_separator EQ thousands_separator.
      RAISE EXCEPTION TYPE zcx_amount_separators
        EXPORTING
          textid              = zcx_amount_separators=>same_separators
          decimal_separator   = decimal_separator
          thousands_separator = thousands_separator
*         amount_string       = string
        .
    ENDIF.

    string = |{ amount NUMBER = RAW  DECIMALS = decimal_places }|.

    IF decimal_places GT 0.
      DATA(decimal_position) = find( val = string  regex = '\.' ).
      REPLACE '.' WITH decimal_separator INTO string.
    ENDIF.


    IF thousands_separator IS NOT INITIAL.
      DATA: current_position TYPE i.
      DATA: thousands_counter TYPE i.
      DATA(string_length) = strlen( string ).

      IF decimal_position EQ 0.
        decimal_position = string_length.
      ENDIF.

      current_position = string_length - 1.
      thousands_counter = 0.

      WHILE current_position GE 0.
        IF   current_position GE decimal_position
          OR current_position EQ 0.
          lv_amount_reversed = |{ lv_amount_reversed }{ string+current_position(1) }|.
        ELSE.
          lv_amount_reversed = |{ lv_amount_reversed }{ string+current_position(1) }|.
          thousands_counter = thousands_counter + 1.

          IF thousands_counter = 3.
            lv_amount_reversed = |{ lv_amount_reversed }{ thousands_separator }|.
            thousands_counter = 0.
          ENDIF.
        ENDIF.

        current_position = current_position - 1.
      ENDWHILE.

      string = reverse( lv_amount_reversed ).
    ENDIF.
  ENDMETHOD.


  METHOD check_separators_in_amount.
    DATA: strlen             TYPE i,
          current_char       TYPE char1,
          position           TYPE i,
          decimal_position   TYPE i,
          thousands_posotion TYPE i,
          number_counter     TYPE i,
          after_thousands    TYPE i.

    IF decimal_separator EQ thousands_separator.
      RAISE EXCEPTION TYPE zcx_amount_separators
        EXPORTING
          textid              = zcx_amount_separators=>same_separators
          decimal_separator   = decimal_separator
          thousands_separator = thousands_separator
*         amount_string       = string
        .
    ENDIF.

    IF    string NS decimal_separator
      AND string NS thousands_separator.
      RETURN.
    ENDIF.


    strlen = strlen( string ).

    WHILE position LT strlen.
      current_char = string+position.

      IF current_char EQ decimal_separator
        AND decimal_position IS INITIAL.
        decimal_position = position.
      ELSEIF current_char EQ decimal_separator  AND decimal_position IS NOT INITIAL.
        RAISE EXCEPTION TYPE zcx_amount_separators
          EXPORTING
            textid              = zcx_amount_separators=>many_decimal_separators
            decimal_separator   = decimal_separator
            thousands_separator = thousands_separator
            amount_string       = string.
      ENDIF.

      IF    current_char EQ thousands_separator
        AND thousands_separator IS NOT INITIAL.

        thousands_posotion = position.

        after_thousands = thousands_posotion + 4.
        number_counter  = strlen - thousands_posotion.
        IF number_counter  LT 4.
*          RAISE thousands_error.
          RAISE EXCEPTION TYPE zcx_amount_separators
            EXPORTING
              textid              = zcx_amount_separators=>thousands_error
              decimal_separator   = decimal_separator
              thousands_separator = thousands_separator
              amount_string       = string.
        ELSEIF after_thousands LT strlen.
          IF    string+after_thousands(1) NE thousands_separator
            AND string+after_thousands(1) NE decimal_separator
            AND string+after_thousands(1) NE '-'.

*            RAISE thousands_error.
            RAISE EXCEPTION TYPE zcx_amount_separators
              EXPORTING
                textid              = zcx_amount_separators=>thousands_error
                decimal_separator   = decimal_separator
                thousands_separator = thousands_separator
                amount_string       = string.
          ENDIF.
        ENDIF.

      ENDIF.


      position = position + 1.
    ENDWHILE.

    IF decimal_position IS NOT INITIAL
      AND thousands_posotion IS NOT INITIAL
      AND decimal_position LT thousands_posotion.

*      RAISE decimal_before_thousands.
      RAISE EXCEPTION TYPE zcx_amount_separators
        EXPORTING
          textid              = zcx_amount_separators=>decimal_before_thousands
          decimal_separator   = decimal_separator
          thousands_separator = thousands_separator
          amount_string       = string.
    ENDIF.

  ENDMETHOD.


  METHOD string_to_amount.

    check_separators_in_amount(
      EXPORTING
        string              = string
        decimal_separator   = decimal_separator   " Single-Character Flag
        thousands_separator = thousands_separator " Single-Character Flag
    ).

    CALL FUNCTION 'HRCM_STRING_TO_AMOUNT_CONVERT'
      EXPORTING
        string              = string
        decimal_separator   = decimal_separator
        thousands_separator = thousands_separator
      IMPORTING
        betrg               = amount
      EXCEPTIONS
        convert_error       = 1
        OTHERS              = 2.

    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE cx_conversion_failed.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
