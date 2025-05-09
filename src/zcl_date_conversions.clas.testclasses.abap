*"* use this source file for your ABAP unit test classes
CLASS ltc_date_conv_intern_to_extern DEFINITION DEFERRED.
CLASS ltc_date_conv_extern_to_intern DEFINITION DEFERRED.
CLASS ltc_constant_pattern DEFINITION DEFERRED.


CLASS ltc_date_conv_intern_to_extern DEFINITION
FINAL
FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      y4m2d2      FOR TESTING,
      y4m2d2_minus FOR TESTING,
      m2d2y4_slash FOR TESTING,
      m2d2y2_slash FOR TESTING,
      m1d1y4_slash FOR TESTING,
      m1d1y2_slash FOR TESTING,
      d2m2y4_slash FOR TESTING,
      d2m2y2_slash FOR TESTING,
      d1m1y4_slash FOR TESTING,
      d1m1y2_slash FOR TESTING,
      m2d2y4_full_stop FOR TESTING ,
      m2d2y2_full_stop FOR TESTING ,
      m1d1y4_full_stop FOR TESTING ,
      m1d1y2_full_stop FOR TESTING ,
      d2m2y4_full_stop FOR TESTING ,
      d2m2y2_full_stop FOR TESTING ,
      d1m1y4_full_stop FOR TESTING ,
      d1m1y2_full_stop FOR TESTING ,
      m2d2y4_minus FOR TESTING,
      m2d2y2_minus FOR TESTING,
      m1d1y4_minus FOR TESTING,
      m1d1y2_minus FOR TESTING,
      d2m2y4_minus FOR TESTING,
      d2m2y2_minus FOR TESTING,
      d1m1y4_minus FOR TESTING,
      d1m1y2_minus FOR TESTING.
ENDCLASS.

CLASS ltc_date_conv_intern_to_extern IMPLEMENTATION.

  METHOD d1m1y2_full_stop.

    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
          date        = '20230601'
          date_format = zif_date_conversions=>c_date_format-d1m1y2_full_stop
      ).

    cl_abap_unit_assert=>assert_equals( exp = '1.6.23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
          date        = '20231107'
          date_format = zif_date_conversions=>c_date_format-d1m1y2_minus
      ).

    cl_abap_unit_assert=>assert_equals( exp = '7-11-23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20230226'
              date_format = zif_date_conversions=>c_date_format-d1m1y2_slash
          ).

    cl_abap_unit_assert=>assert_equals( exp = '26/2/23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20230601'
              date_format = zif_date_conversions=>c_date_format-d1m1y4_full_stop
          ).

    cl_abap_unit_assert=>assert_equals( exp = '1.6.2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20231107'
              date_format = zif_date_conversions=>c_date_format-d1m1y4_minus
          ).

    cl_abap_unit_assert=>assert_equals( exp = '7-11-2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d1m1y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230226'
                  date_format = zif_date_conversions=>c_date_format-d1m1y4_slash
              ).

    cl_abap_unit_assert=>assert_equals( exp = '26/2/2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d2m2y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20230601'
              date_format = zif_date_conversions=>c_date_format-d2m2y2_full_stop
          ).

    cl_abap_unit_assert=>assert_equals( exp = '01.06.23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d2m2y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20231107'
              date_format = zif_date_conversions=>c_date_format-d2m2y2_minus
          ).

    cl_abap_unit_assert=>assert_equals( exp = '07-11-23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d2m2y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230226'
                  date_format = zif_date_conversions=>c_date_format-d2m2y2_slash
              ).

    cl_abap_unit_assert=>assert_equals( exp = '26/02/23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d2m2y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230601'
                  date_format = zif_date_conversions=>c_date_format-d2m2y4_full_stop
              ).

    cl_abap_unit_assert=>assert_equals( exp = '01.06.2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d2m2y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20231107'
              date_format = zif_date_conversions=>c_date_format-d2m2y4_minus
          ).

    cl_abap_unit_assert=>assert_equals( exp = '07-11-2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  d2m2y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                      date        = '20230226'
                      date_format = zif_date_conversions=>c_date_format-d2m2y4_slash
                  ).

    cl_abap_unit_assert=>assert_equals( exp = '26/02/2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m1d1y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20230601'
              date_format = zif_date_conversions=>c_date_format-m1d1y2_full_stop
          ).

    cl_abap_unit_assert=>assert_equals( exp = '6.1.23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m1d1y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
          date        = '20231107'
          date_format = zif_date_conversions=>c_date_format-m1d1y2_minus
      ).

    cl_abap_unit_assert=>assert_equals( exp = '11-7-23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m1d1y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230226'
                  date_format = zif_date_conversions=>c_date_format-m1d1y2_slash
              ).

    cl_abap_unit_assert=>assert_equals( exp = '2/26/23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m1d1y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20230601'
              date_format = zif_date_conversions=>c_date_format-m1d1y4_full_stop
          ).

    cl_abap_unit_assert=>assert_equals( exp = '6.1.2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m1d1y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20231107'
              date_format = zif_date_conversions=>c_date_format-m1d1y4_minus
          ).

    cl_abap_unit_assert=>assert_equals( exp = '11-7-2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m1d1y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230226'
                  date_format = zif_date_conversions=>c_date_format-m1d1y4_slash
              ).

    cl_abap_unit_assert=>assert_equals( exp = '2/26/2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m2d2y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20230601'
              date_format = zif_date_conversions=>c_date_format-m2d2y2_full_stop
          ).

    cl_abap_unit_assert=>assert_equals( exp = '06.01.23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m2d2y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20231107'
              date_format = zif_date_conversions=>c_date_format-m2d2y2_minus
          ).

    cl_abap_unit_assert=>assert_equals( exp = '11-07-23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m2d2y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230226'
                  date_format = zif_date_conversions=>c_date_format-m2d2y2_slash
              ).

    cl_abap_unit_assert=>assert_equals( exp = '02/26/23'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m2d2y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                  date        = '20230601'
                  date_format = zif_date_conversions=>c_date_format-m2d2y4_full_stop
              ).

    cl_abap_unit_assert=>assert_equals( exp = '06.01.2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m2d2y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
              date        = '20231107'
              date_format = zif_date_conversions=>c_date_format-m2d2y4_minus
          ).

    cl_abap_unit_assert=>assert_equals( exp = '11-07-2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  m2d2y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
                      date        = '20230226'
                      date_format = zif_date_conversions=>c_date_format-m2d2y4_slash
                  ).

    cl_abap_unit_assert=>assert_equals( exp = '02/26/2023'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  y4m2d2.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
          date        = sy-datum
          date_format = zif_date_conversions=>c_date_format-y4m2d2
      ).

    cl_abap_unit_assert=>assert_equals( exp = sy-datum
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD  y4m2d2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_intern_to_extern_2(
          date        = sy-datum
          date_format = zif_date_conversions=>c_date_format-y4m2d2_minus
      ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(4) }-{ sy-datum+4(2) }-{ sy-datum+6(2) }|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

ENDCLASS.











CLASS ltc_date_conv_extern_to_intern DEFINITION
FINAL
FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    METHODS:
      y4m2d2            FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      y4m2d2_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m2d2y4_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m2d2y2_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m1d1y4_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m1d1y2_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d2m2y4_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d2m2y2_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d1m1y4_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d1m1y2_slash      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m2d2y4_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m2d2y2_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m1d1y4_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m1d1y2_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d2m2y4_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d2m2y2_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d1m1y4_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d1m1y2_full_stop  FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m2d2y4_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m2d2y2_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m1d1y4_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      m1d1y2_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d2m2y4_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d2m2y2_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d1m1y4_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      d1m1y2_minus      FOR TESTING RAISING zcx_date_conv_invalid_format
                                            zcx_date_conv_invalid_date,
      invalid_date      FOR TESTING RAISING zcx_date_conv_invalid_format,
      invalid_date_format    FOR TESTING RAISING zcx_date_conv_invalid_date.
ENDCLASS.

CLASS ltc_date_conv_extern_to_intern IMPLEMENTATION.

  METHOD d1m1y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '1.6.23'
             date_format   = zif_date_conversions=>c_date_format-d1m1y2_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230601|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '7-11-23'
             date_format   = zif_date_conversions=>c_date_format-d1m1y2_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }231107|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '26/2/23'
             date_format   = zif_date_conversions=>c_date_format-d1m1y2_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230226|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '1.6.2023'
             date_format   = zif_date_conversions=>c_date_format-d1m1y4_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230601'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '7-11-2023'
             date_format   = zif_date_conversions=>c_date_format-d1m1y4_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20231107'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d1m1y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '26/2/2023'
             date_format   = zif_date_conversions=>c_date_format-d1m1y4_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230226'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d2m2y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '01.06.23'
             date_format   = zif_date_conversions=>c_date_format-d2m2y2_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230601|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d2m2y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '07-11-23'
             date_format   = zif_date_conversions=>c_date_format-d2m2y2_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }231107|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d2m2y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '26/02/23'
             date_format   = zif_date_conversions=>c_date_format-d2m2y2_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230226|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d2m2y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '01.06.2023'
             date_format   = zif_date_conversions=>c_date_format-d2m2y4_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230601'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d2m2y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '07-11-2023'
             date_format   = zif_date_conversions=>c_date_format-d2m2y4_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20231107'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD d2m2y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '26/02/2023'
             date_format   = zif_date_conversions=>c_date_format-d2m2y4_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230226'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m1d1y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '6.1.23'
             date_format   = zif_date_conversions=>c_date_format-m1d1y2_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230601|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m1d1y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '11-7-23'
             date_format   = zif_date_conversions=>c_date_format-m1d1y2_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }231107|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m1d1y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '2/26/23'
             date_format   = zif_date_conversions=>c_date_format-m1d1y2_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230226|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m1d1y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '6.1.2023'
             date_format   = zif_date_conversions=>c_date_format-m1d1y4_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230601'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m1d1y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '11-7-2023'
             date_format   = zif_date_conversions=>c_date_format-m1d1y4_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20231107'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m1d1y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '2/26/2023'
             date_format   = zif_date_conversions=>c_date_format-m1d1y4_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230226'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m2d2y2_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '06.01.23'
             date_format   = zif_date_conversions=>c_date_format-m2d2y2_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230601|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m2d2y2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '11-07-23'
             date_format   = zif_date_conversions=>c_date_format-m2d2y2_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }231107|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m2d2y2_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '02/26/23'
             date_format   = zif_date_conversions=>c_date_format-m2d2y2_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = |{ sy-datum(2) }230226|
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m2d2y4_full_stop.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '06.01.2023'
             date_format   = zif_date_conversions=>c_date_format-m2d2y4_full_stop
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230601'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m2d2y4_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '11-07-2023'
             date_format   = zif_date_conversions=>c_date_format-m2d2y4_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20231107'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD m2d2y4_slash.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  =  '02/26/2023'
             date_format   = zif_date_conversions=>c_date_format-m2d2y4_slash
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = '20230226'
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD y4m2d2.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  = sy-datum
             date_format   = zif_date_conversions=>c_date_format-y4m2d2
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = sy-datum
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD y4m2d2_minus.
    DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
             date_in_text  = |{ sy-datum(4) }-{ sy-datum+4(2) }-{ sy-datum+6(2) }|
             date_format   = zif_date_conversions=>c_date_format-y4m2d2_minus
             bypass_buffer = abap_true
         ).

    cl_abap_unit_assert=>assert_equals( exp = sy-datum
                                        act = date_internal
                                        msg = 'False conversion' ).
  ENDMETHOD.

  METHOD invalid_date.

    TRY .
        DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
                 date_in_text  =  '26/02/2023'
                 date_format   = zif_date_conversions=>c_date_format-m2d2y4_slash
                 bypass_buffer = abap_true
             ).

        cl_abap_unit_assert=>fail( msg = 'Expected exception was not raised' ).
      CATCH zcx_date_conv_invalid_date.

    ENDTRY.

  ENDMETHOD.

  METHOD invalid_date_format.
    TRY .
        DATA(date_internal) = zcl_date_conversions=>convert_external_to_internal(
                 date_in_text  =  '26/02/2023'
                 date_format   = 'mdy'
                 bypass_buffer = abap_true
             ).

        cl_abap_unit_assert=>fail( msg = 'Expected exception was not raised' ).
      CATCH zcx_date_conv_invalid_format.

    ENDTRY.
  ENDMETHOD.
ENDCLASS.



CLASS ltc_constant_pattern DEFINITION
FINAL
FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA domain_values TYPE STANDARD TABLE OF dd07v.
    DATA components_of_const_structure TYPE cl_abap_structdescr=>component_table.
    METHODS setup.
    METHODS all_values_as_constant FOR TESTING.
    METHODS all_constants_in_domain FOR TESTING.
ENDCLASS.


CLASS ltc_constant_pattern IMPLEMENTATION.
  METHOD setup.
    CALL FUNCTION 'DD_DOMVALUES_GET'
      EXPORTING
        domname   = 'Z_D_DATE_FORMAT'
      TABLES
        dd07v_tab = domain_values
      EXCEPTIONS
        OTHERS    = 1.
    ASSERT sy-subrc = 0.
    DATA: lo_struct_descr TYPE REF TO cl_abap_structdescr.
    lo_struct_descr ?= cl_abap_typedescr=>describe_by_data(
    zif_date_conversions=>c_date_format ).
    components_of_const_structure =
    lo_struct_descr->get_components( ).
  ENDMETHOD.
  METHOD all_constants_in_domain.
    LOOP AT components_of_const_structure INTO DATA(component).
      ASSIGN COMPONENT component-name
      OF STRUCTURE zif_date_conversions=>c_date_format
      TO FIELD-SYMBOL(<value>).
      ASSERT sy-subrc = 0.
      IF NOT line_exists( domain_values[ domvalue_l = <value> ] ).
        cl_abap_unit_assert=>fail( |Component { component-name } not found in domain fix values| ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD all_values_as_constant.
    DATA value_found TYPE abap_bool.
    LOOP AT domain_values INTO DATA(domain_value).
      CLEAR value_found.
      LOOP AT components_of_const_structure INTO DATA(component).
        ASSIGN COMPONENT component-name
        OF STRUCTURE zif_date_conversions=>c_date_format
        TO FIELD-SYMBOL(<value>).
        ASSERT sy-subrc = 0.
        IF domain_value-domvalue_l = <value>.
          value_found = abap_true.
          EXIT.
        ENDIF.
      ENDLOOP.
      IF value_found = abap_false.
        cl_abap_unit_assert=>fail( |Domainvalue { domain_value-domvalue_l } not available as constant| ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
