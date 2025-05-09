*"* use this source file for your ABAP unit test classes

CLASS ltc_amount_conversions DEFINITION
FINAL
FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES: BEGIN OF ty_test_case,
             amount              TYPE zcl_amount_conversions=>ty_abap_max_packed_number,
             decimal_separator   TYPE char1,
             thousands_separator TYPE char1,
             decimals            TYPE i,
             amount_in_string    TYPE string,
           END OF ty_test_case.

    DATA: lt_test_cases TYPE TABLE OF ty_test_case.

    METHODS setup.
    METHODS amount_to_string FOR TESTING
      RAISING zcx_amount_separators.
    METHODS sting_to_amount FOR TESTING
      RAISING cx_conversion_failed
              zcx_amount_separators.

ENDCLASS.


CLASS ltc_amount_conversions IMPLEMENTATION.

  METHOD setup.
    me->lt_test_cases = VALUE #( ( amount = '9999999999999999999999.999999999'  decimal_separator = ',' thousands_separator = '.' decimals = 9 amount_in_string = '9.999.999.999.999.999.999.999,999999999'  )
                                 ( amount = '9999999999999999999999.999999999-' decimal_separator = ',' thousands_separator = '.' decimals = 9 amount_in_string = '-9.999.999.999.999.999.999.999,999999999' )
*   error!  initial = space      ( amount = '9999999999999999999999.999990000-' decimal_separator = ',' thousands_separator = ' ' decimals = 5 amount_in_string = '-9 999 999 999 999 999 999 999,99999' )
                                 ( amount = '12345678.680000000'                decimal_separator = '.' thousands_separator = ',' decimals = 2 amount_in_string = '12,345,678.68' )
                               ).
  ENDMETHOD.

  METHOD amount_to_string.
    LOOP AT me->lt_test_cases ASSIGNING FIELD-SYMBOL(<test_case>).
      DATA(converted_amount) = zcl_amount_conversions=>amount_to_string(
                                 amount              = <test_case>-amount
                                 decimal_separator   = <test_case>-decimal_separator
                                 thousands_separator = <test_case>-thousands_separator
                                 decimal_places      = <test_case>-decimals
                               ).

      cl_abap_unit_assert=>assert_equals( exp = <test_case>-amount_in_string
                                          act = converted_amount
                                          msg = 'False conversion' ).


    ENDLOOP.
  ENDMETHOD.

  METHOD sting_to_amount.
    LOOP AT me->lt_test_cases ASSIGNING FIELD-SYMBOL(<test_case>).
      DATA(converted_amount) = zcl_amount_conversions=>string_to_amount(
                                 string              = <test_case>-amount_in_string
                                 decimal_separator   = <test_case>-decimal_separator
                                 thousands_separator = <test_case>-thousands_separator
                               ).

      cl_abap_unit_assert=>assert_equals( exp = <test_case>-amount
                                          act = converted_amount
                                          msg = 'False conversion' ).

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
