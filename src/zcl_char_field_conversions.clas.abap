class ZCL_CHAR_FIELD_CONVERSIONS definition
  public
  final
  create public .

public section.

  class-methods STRING_TO_CHAR
    importing
      !STRING type STRING
    exporting
      !CHARACTER_FIELD type ANY
    raising
      resumable(ZCX_STRING_LENGTH_TOO_LARGE)
      ZCX_CONVERSION_EXIT_INPUT_ERR
      ZCX_CUST_CONV_UNSUPPORTED_TYPE .
  class-methods CALL_CONVERSION_EXIT_INPUT
    importing
      !CONVERSION_EXIT type CONVEXIT
      !IMPORTING_VALUE type ANY
    exporting
      !EXPORTING_VALUE type ANY
    raising
      ZCX_CONVERSION_EXIT_INPUT_ERR
      CX_SY_DYN_CALL_ILLEGAL_FUNC .
  class-methods CHAR_TO_STRING
    importing
      !CHARACTER_FIELD type ANY
    returning
      value(STRING) type STRING
    raising
      ZCX_CUST_CONV_UNSUPPORTED_TYPE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_CHAR_FIELD_CONVERSIONS IMPLEMENTATION.


  METHOD call_conversion_exit_input.

    DATA: function_name TYPE string.

    CONCATENATE 'CONVERSION_EXIT_' conversion_exit '_INPUT' INTO function_name.

*    TRY .

        CALL FUNCTION function_name
          EXPORTING
            input  = importing_value
          IMPORTING
            output = exporting_value
          EXCEPTIONS
            OTHERS = 4.

        IF sy-subrc NE 0.
          RAISE EXCEPTION TYPE zcx_conversion_exit_input_err
            EXPORTING
*             textid             =
*             previous           =
              message_type       = sy-msgty
              message_number     = sy-msgno
              message_id         = sy-msgid
              message_variable_1 = sy-msgv1
              message_variable_2 = sy-msgv2
              message_variable_3 = sy-msgv3
              message_variable_4 = sy-msgv4.
        ENDIF.

*      CATCH cx_sy_dyn_call_illegal_func INTO DATA(lcx_sy_dyn_call_illegal_func).
*
*    ENDTRY.

  ENDMETHOD.


  METHOD char_to_string.
    DATA: lo_elemdescr TYPE REF TO cl_abap_elemdescr.
    DATA: ls_dfies TYPE dfies.
    DATA: ls_fieldinfo TYPE rsanu_s_fieldinfo.

    lo_elemdescr ?= cl_abap_elemdescr=>describe_by_data( character_field ).

    CASE lo_elemdescr->type_kind.
      WHEN cl_abap_structdescr=>typekind_char
             OR cl_abap_structdescr=>typekind_clike
             OR cl_abap_structdescr=>typekind_csequence
             OR cl_abap_structdescr=>typekind_string.
        "Continue normaly
      WHEN OTHERS.
        "raise exception conversion not supported
        RAISE EXCEPTION TYPE zcx_cust_conv_unsupported_type
          EXPORTING
            typekind = lo_elemdescr->type_kind.
    ENDCASE.

    IF lo_elemdescr->is_ddic_type( ) EQ abap_true.

      lo_elemdescr->get_ddic_field(
        EXPORTING
          p_langu      = sy-langu   " Current language
        RECEIVING
          p_flddescr   = ls_dfies " Field description
        EXCEPTIONS
          not_found    = 1          " Type could not be found
          no_ddic_type = 2          " Typ is not a dictionary type
          OTHERS       = 3
      ).
      IF sy-subrc EQ 0.
        MOVE-CORRESPONDING ls_dfies TO ls_fieldinfo.
        IF ls_fieldinfo-convexit IS NOT INITIAL.

          cl_rsan_ut_conversion_exit=>convert_to_extern(
            EXPORTING
              i_fieldinfo      = ls_fieldinfo      " I_FIELDINFO
              i_internal_value = character_field " I_INTERNAL_VALUE
            IMPORTING
              e_external_value = string " E_EXTERNAL_VALUE
          ).
        ENDIF.
      ENDIF.
    ENDIF.

    IF string IS INITIAL.
      string = CONV string( character_field ).
    ENDIF.

  ENDMETHOD.


  METHOD string_to_char.
    DATA: lo_edescr TYPE REF TO cl_abap_elemdescr.
    DATA: lv_character_length TYPE i.
    DATA: lv_string TYPE string.
    DATA: ls_dfies TYPE dfies.


    CLEAR character_field.


    lo_edescr ?= cl_abap_elemdescr=>describe_by_data( character_field ).

    CASE lo_edescr->type_kind.
      WHEN cl_abap_structdescr=>typekind_char
        OR cl_abap_structdescr=>typekind_clike
        OR cl_abap_structdescr=>typekind_csequence
        OR cl_abap_structdescr=>typekind_num
        OR cl_abap_structdescr=>typekind_string.
        "Continue normaly
      WHEN OTHERS.
        "raise exception conversion not supported
        RAISE EXCEPTION TYPE zcx_cust_conv_unsupported_type
          EXPORTING
            typekind = lo_edescr->type_kind.
    ENDCASE.


    lv_character_length = lo_edescr->length.

    DATA(lv_strlen) = strlen( string ).
    IF lv_strlen GT lv_character_length .

      RAISE RESUMABLE EXCEPTION TYPE zcx_string_length_too_large
        EXPORTING
          textid                = zcx_string_length_too_large=>string_length_gt_expected
          string_length_i       = lv_strlen
          max_expected_length_i = lv_character_length
          string_length         = |{ lv_strlen ALIGN = LEFT }|
          max_expected_length   = |{ lv_character_length ALIGN = LEFT }|
          string                = string.
    ENDIF.

    TRY .
        lv_string = string(lv_character_length).
      CATCH cx_sy_range_out_of_bounds.
        lv_string = string.
    ENDTRY.


    IF lo_edescr->is_ddic_type( ) EQ abap_true.
      lo_edescr->get_ddic_field(
         EXPORTING
           p_langu      = sy-langu   " Current language
         RECEIVING
           p_flddescr   = ls_dfies " Field description
         EXCEPTIONS
           not_found    = 1          " Type could not be found
           no_ddic_type = 2          " Typ is not a dictionary type
           OTHERS       = 3
       ).
      IF sy-subrc <> 0.
        CLEAR ls_dfies.


      ELSEIF sy-subrc EQ 0.
        IF ls_dfies-convexit IS NOT INITIAL.

          TRY .
              call_conversion_exit_input(
                    EXPORTING
                       conversion_exit  = ls_dfies-convexit
                       importing_value  = lv_string
                    IMPORTING
                       exporting_value = character_field ).
            CATCH cx_sy_dyn_call_illegal_func.
          ENDTRY.

        ENDIF.

      ENDIF.
    ENDIF.

    IF character_field IS INITIAL.
*      CHARACTER_FIELD = CONV #( string ).
      character_field = string .
    ENDIF.
  ENDMETHOD.
ENDCLASS.
