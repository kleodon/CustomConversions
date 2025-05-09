class ZCL_DATE_CONVERSIONS definition
  public
  final
  create public .

public section.

  interfaces ZIF_DATE_CONVERSIONS .

  class-methods GET_REGEX_FROM_DATE_FORMAT
    importing
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT
    returning
      value(REGEX) type ref to CL_ABAP_REGEX
    raising
      CX_SY_INVALID_REGEX_OPERATION
      CX_SY_REGEX
      ZCX_DATE_CONV_INVALID_FORMAT .
  class-methods CONVERT_EXTERNAL_TO_INTERNAL
    importing
      !DATE_IN_TEXT type CLIKE
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT
      !BYPASS_BUFFER type ABAP_BOOL default ABAP_FALSE
    returning
      value(RESULT) type DATS
    raising
      CX_SY_INVALID_REGEX_OPERATION
      CX_SY_REGEX
      CX_SY_MATCHER
      ZCX_DATE_CONV_INVALID_FORMAT
      ZCX_DATE_CONV_INVALID_DATE .
  class-methods GET_DATE_SEQUENCE_FROM_FORMAT
    importing
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT
    returning
      value(DATE_SEQUENCE) type ZIF_DATE_CONVERSIONS=>TY_DATE_SEQUENCE .
  class-methods CONVERT_INTERN_TO_EXTERN_1
    importing
      !DATE type DATS
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT
    returning
      value(RESULT) type STRING .
  class-methods CONVERT_INTERN_TO_EXTERN_2
    importing
      !DATE type DATS
      !DATE_FORMAT type ZIF_DATE_CONVERSIONS=>TY_DATE_FORMAT
    returning
      value(RESULT) type STRING .
  class-methods RESET_BUFFER .
protected section.
private section.

  class-data BUFFER type ref to ZCL_DATE_CONVERSIONS_BUFFER .
ENDCLASS.



CLASS ZCL_DATE_CONVERSIONS IMPLEMENTATION.


  METHOD convert_external_to_internal.
    DATA: lv_day   TYPE numc2.
    DATA: lv_month TYPE numc2.
    DATA: lv_year  TYPE numc4.

    DATA: regex TYPE REF TO cl_abap_regex.
    DATA: date_sequence TYPE zif_date_conversions=>ty_date_sequence.

    CLEAR result.

    IF   bypass_buffer EQ abap_true
      OR buffer        IS NOT BOUND.

      regex = get_regex_from_date_format( date_format ).
      date_sequence = get_date_sequence_from_format( date_format ).

    ELSEIF buffer IS BOUND.

      IF  buffer->get_date_format( ) EQ date_format.
        regex = buffer->get_regex( ).
        date_sequence = buffer->get_date_sequence( ).
      ELSE.
        regex = get_regex_from_date_format( date_format ).
        date_sequence = get_date_sequence_from_format( date_format ).

        IF bypass_buffer EQ abap_false.
          buffer->set_date_format( date_format ).
          buffer->set_date_sequence( date_sequence ).
          buffer->set_regex( regex ).
        ENDIF.
      ENDIF.

    ENDIF.





*    DATA(regex) = get_regex_from_date_format( date_format ).

    DATA(matcher) = regex->create_matcher( text = date_in_text ).

    DATA(match_result) =  matcher->match( ).

    IF match_result EQ abap_false.

      RAISE EXCEPTION TYPE zcx_date_conv_invalid_date
        EXPORTING
          invalid_date = date_in_text.
    ENDIF.



*    DATA(date_sequence) = get_date_sequence_from_format( date_format ).

    CASE date_sequence.
      WHEN zif_date_conversions=>c_date_sequence-ymd.
        lv_day   = matcher->get_submatch( index = 3 ).
        lv_month = matcher->get_submatch( index = 2 ).
        lv_year  = matcher->get_submatch( index = 1 ).

      WHEN zif_date_conversions=>c_date_sequence-dmy.
        lv_day   = matcher->get_submatch( index = 1 ).
        lv_month = matcher->get_submatch( index = 2 ).
        lv_year  = matcher->get_submatch( index = 3 ).

      WHEN zif_date_conversions=>c_date_sequence-mdy.
        lv_day   = matcher->get_submatch( index = 2 ).
        lv_month = matcher->get_submatch( index = 1 ).
        lv_year  = matcher->get_submatch( index = 3 ).

    ENDCASE.

    CASE date_format.
      WHEN zif_date_conversions=>c_date_format-m2d2y2_slash
        OR zif_date_conversions=>c_date_format-m1d1y2_slash
        OR zif_date_conversions=>c_date_format-d2m2y2_slash
        OR zif_date_conversions=>c_date_format-d1m1y2_slash
        OR zif_date_conversions=>c_date_format-m2d2y2_full_stop
        OR zif_date_conversions=>c_date_format-m1d1y2_full_stop
        OR zif_date_conversions=>c_date_format-d2m2y2_full_stop
        OR zif_date_conversions=>c_date_format-d1m1y2_full_stop
        OR zif_date_conversions=>c_date_format-m2d2y2_minus
        OR zif_date_conversions=>c_date_format-m1d1y2_minus
        OR zif_date_conversions=>c_date_format-d2m2y2_minus
        OR zif_date_conversions=>c_date_format-d1m1y2_minus.

        lv_year(2) = sy-datum(2).
    ENDCASE.

    CONCATENATE lv_year
                lv_month
                lv_day
          INTO  result.

    CALL FUNCTION 'DATE_CHECK_PLAUSIBILITY'
      EXPORTING
        date                      = result
      EXCEPTIONS
        plausibility_check_failed = 1
        OTHERS                    = 2.

    IF sy-subrc NE 0.
      CLEAR result.
      RAISE EXCEPTION TYPE zcx_date_conv_invalid_date
        EXPORTING
          invalid_date = date_in_text.
    ENDIF.


    IF    bypass_buffer EQ abap_false
      AND buffer        IS NOT BOUND.
      buffer = zcl_date_conversions_buffer=>get_object( ).
      buffer->set_date_format( date_format ).
      buffer->set_date_sequence( date_sequence ).
      buffer->set_regex( regex ).
    ENDIF.

  ENDMETHOD.


  METHOD convert_intern_to_extern_1.
    "Loop at every character, slightly slower than replace characters.

    DATA: i TYPE i.
    DATA: j TYPE i.
    DATA: number_of_d TYPE i.
    DATA: number_of_m TYPE i.
    DATA: number_of_y TYPE i.
    DATA: current_character TYPE char1.
    DATA: previous_character TYPE char1.
    DATA: lv_string TYPE string.

    i = strlen( date_format ).


    WHILE i GT 0.
      i = i - 1.
      j = i - 1.

      current_character = date_format+i(1).
      IF j GE 0.
        previous_character =  date_format+j(1).
      ELSE.
        CLEAR previous_character.
      ENDIF.



      CASE current_character.
        WHEN 'D'.
          number_of_d = number_of_d + 1.

          IF number_of_d EQ 1.
            CONCATENATE lv_string date+7(1) INTO lv_string.
          ELSEIF number_of_d EQ 2.
            CONCATENATE lv_string date+6(1) INTO lv_string.
          ENDIF.


        WHEN 'M'.
          number_of_m = number_of_m + 1.

          IF number_of_m EQ 1.
            CONCATENATE lv_string date+5(1) INTO lv_string.
          ELSEIF number_of_m EQ 2.
            CONCATENATE lv_string date+4(1) INTO lv_string.
          ENDIF.


        WHEN 'Y'.
          number_of_y = number_of_y + 1.

          IF number_of_y EQ 1.
            CONCATENATE lv_string date+3(1) INTO lv_string.
          ELSEIF number_of_y EQ 2.
            CONCATENATE lv_string date+2(1) INTO lv_string.
          ELSEIF number_of_y EQ 3.
            CONCATENATE lv_string date+1(1) INTO lv_string.
          ELSEIF number_of_y EQ 4.
            CONCATENATE lv_string date+0(1) INTO lv_string.
          ENDIF.


        WHEN OTHERS. "dilemeter
          CONCATENATE lv_string current_character INTO lv_string.
      ENDCASE.



      IF   previous_character IS INITIAL
        OR ( previous_character NE 'D' AND previous_character NE 'M' AND previous_character NE 'Y' ).

        IF number_of_d EQ 1
          AND date+6(1) NE 0.
          CONCATENATE lv_string date+6(1) INTO lv_string.
        ENDIF.

        IF number_of_m EQ 1
          AND date+4(1) NE 0.
          CONCATENATE lv_string date+4(1) INTO lv_string.
        ENDIF.

      ENDIF.

    ENDWHILE.

    result = reverse( lv_string ).


  ENDMETHOD.


  METHOD CONVERT_INTERN_TO_EXTERN_2.
    "Replace characters, slightly faster than loop at every character.
    DATA: alpha TYPE string.

    result = date_format.

    REPLACE 'DD' INTO result WITH date+6(2).
    IF sy-subrc NE 0.
      alpha = |{ date+6(2) ALPHA = OUT  }|.
      CONDENSE alpha NO-GAPS.
      REPLACE 'D' INTO result WITH alpha.
    ENDIF.

    REPLACE 'MM' INTO result WITH date+4(2).
    IF sy-subrc NE 0.
      alpha = |{ date+4(2) ALPHA = OUT }|.
      CONDENSE alpha NO-GAPS.
      REPLACE 'M' INTO result WITH alpha.
    ENDIF.

    REPLACE 'YYYY' INTO result WITH date(4).
    IF sy-subrc NE 0.
      REPLACE 'YY' INTO result WITH date+2(2).
    ENDIF.


  ENDMETHOD.


  METHOD get_date_sequence_from_format.

    IF date_format IS INITIAL.
      RETURN.
    ENDIF.

    CLEAR date_sequence.

    CASE date_format.
      WHEN zif_date_conversions=>c_date_format-y4m2d2
        OR zif_date_conversions=>c_date_format-y4m2d2_minus.

        date_sequence = ZIF_DATE_CONVERSIONS=>c_date_sequence-ymd.

      WHEN zif_date_conversions=>c_date_format-m2d2y4_slash
        OR zif_date_conversions=>c_date_format-m2d2y2_slash
        OR zif_date_conversions=>c_date_format-m1d1y4_slash
        OR zif_date_conversions=>c_date_format-m1d1y2_slash
        OR zif_date_conversions=>c_date_format-m2d2y4_full_stop
        OR zif_date_conversions=>c_date_format-m2d2y2_full_stop
        OR zif_date_conversions=>c_date_format-m1d1y4_full_stop
        OR zif_date_conversions=>c_date_format-m1d1y2_full_stop
        OR zif_date_conversions=>c_date_format-m2d2y4_minus
        OR zif_date_conversions=>c_date_format-m2d2y2_minus
        OR zif_date_conversions=>c_date_format-m1d1y4_minus
        OR zif_date_conversions=>c_date_format-m1d1y2_minus.

        date_sequence = ZIF_DATE_CONVERSIONS=>c_date_sequence-mdy.

      WHEN zif_date_conversions=>c_date_format-d2m2y4_slash
        OR zif_date_conversions=>c_date_format-d2m2y2_slash
        OR zif_date_conversions=>c_date_format-d1m1y4_slash
        OR zif_date_conversions=>c_date_format-d1m1y2_slash
        OR zif_date_conversions=>c_date_format-d2m2y4_full_stop
        OR zif_date_conversions=>c_date_format-d2m2y2_full_stop
        OR zif_date_conversions=>c_date_format-d1m1y4_full_stop
        OR zif_date_conversions=>c_date_format-d1m1y2_full_stop
        OR zif_date_conversions=>c_date_format-d2m2y4_minus
        OR zif_date_conversions=>c_date_format-d2m2y2_minus
        OR zif_date_conversions=>c_date_format-d1m1y4_minus
        OR zif_date_conversions=>c_date_format-d1m1y2_minus.

        date_sequence = ZIF_DATE_CONVERSIONS=>c_date_sequence-dmy.
    ENDCASE.
  ENDMETHOD.


  METHOD get_regex_from_date_format.

    IF date_format IS INITIAL.
      RETURN.
    ENDIF.

    CASE date_format.
      WHEN zif_date_conversions=>c_date_format-y4m2d2
        OR zif_date_conversions=>c_date_format-y4m2d2_minus.
*        regex = cl_abap_regex=>create_pcre( '\b(\d{4})[./-]*(\d{2})[./-]*(\d{2})\b' ).
        regex = NEW cl_abap_regex( '\b(\d{4})[./-]*(\d{2})[./-]*(\d{2})\b' ).

      WHEN zif_date_conversions=>c_date_format-m2d2y4_slash
        OR zif_date_conversions=>c_date_format-m2d2y2_slash
        OR zif_date_conversions=>c_date_format-m1d1y4_slash
        OR zif_date_conversions=>c_date_format-m1d1y2_slash
        OR zif_date_conversions=>c_date_format-d2m2y4_slash
        OR zif_date_conversions=>c_date_format-d2m2y2_slash
        OR zif_date_conversions=>c_date_format-d1m1y4_slash
        OR zif_date_conversions=>c_date_format-d1m1y2_slash
        OR zif_date_conversions=>c_date_format-m2d2y4_full_stop
        OR zif_date_conversions=>c_date_format-m2d2y2_full_stop
        OR zif_date_conversions=>c_date_format-m1d1y4_full_stop
        OR zif_date_conversions=>c_date_format-m1d1y2_full_stop
        OR zif_date_conversions=>c_date_format-d2m2y4_full_stop
        OR zif_date_conversions=>c_date_format-d2m2y2_full_stop
        OR zif_date_conversions=>c_date_format-d1m1y4_full_stop
        OR zif_date_conversions=>c_date_format-d1m1y2_full_stop
        OR zif_date_conversions=>c_date_format-m2d2y4_minus
        OR zif_date_conversions=>c_date_format-m2d2y2_minus
        OR zif_date_conversions=>c_date_format-m1d1y4_minus
        OR zif_date_conversions=>c_date_format-m1d1y2_minus
        OR zif_date_conversions=>c_date_format-d2m2y4_minus
        OR zif_date_conversions=>c_date_format-d2m2y2_minus
        OR zif_date_conversions=>c_date_format-d1m1y4_minus
        OR zif_date_conversions=>c_date_format-d1m1y2_minus.

*        regex = cl_abap_regex=>create_pcre( '\b(\d{1,2})[./-](\d{1,2})[./-](\d{2,4})\b' ).
        regex = NEW cl_abap_regex( '\b(\d{1,2})[./-](\d{1,2})[./-](\d{2,4})\b' ).




      WHEN OTHERS.
        "raise exceprion invalid format
        RAISE EXCEPTION TYPE zcx_date_conv_invalid_format
          EXPORTING
*           textid      = textid
*           previous    = previous
            date_format = date_format.
    ENDCASE.
  ENDMETHOD.


  METHOD reset_buffer.
    IF buffer IS BOUND.
      buffer->free_object( ).
      FREE buffer.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
