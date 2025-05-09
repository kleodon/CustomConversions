interface ZIF_DATE_CONVERSIONS
  public .


  types TY_DATE_SEQUENCE type CHAR3 .
  types TY_DATE_FORMAT type Z_E_DATE_FORMAT .

  constants:
    BEGIN OF c_date_sequence,
        ymd TYPE ty_date_sequence VALUE 'ymd',
        dmy TYPE ty_date_sequence VALUE 'dmy',
        mdy TYPE ty_date_sequence VALUE 'mdy',
      END OF c_date_sequence .
  constants:
    BEGIN OF c_date_format,
        y4m2d2           TYPE ty_date_format VALUE 'YYYYMMDD',
        y4m2d2_minus     TYPE ty_date_format VALUE 'YYYY-MM-DD',
        m2d2y4_slash     TYPE ty_date_format VALUE 'MM/DD/YYYY',
        m2d2y2_slash     TYPE ty_date_format VALUE 'MM/DD/YY',
        m1d1y4_slash     TYPE ty_date_format VALUE 'M/D/YYYY',
        m1d1y2_slash     TYPE ty_date_format VALUE 'M/D/YY',
        d2m2y4_slash     TYPE ty_date_format VALUE 'DD/MM/YYYY',
        d2m2y2_slash     TYPE ty_date_format VALUE 'DD/MM/YY',
        d1m1y4_slash     TYPE ty_date_format VALUE 'D/M/YYYY',
        d1m1y2_slash     TYPE ty_date_format VALUE 'D/M/YY',
        m2d2y4_full_stop TYPE ty_date_format VALUE 'MM.DD.YYYY',
        m2d2y2_full_stop TYPE ty_date_format VALUE 'MM.DD.YY',
        m1d1y4_full_stop TYPE ty_date_format VALUE 'M.D.YYYY',
        m1d1y2_full_stop TYPE ty_date_format VALUE 'M.D.YY',
        d2m2y4_full_stop TYPE ty_date_format VALUE 'DD.MM.YYYY',
        d2m2y2_full_stop TYPE ty_date_format VALUE 'DD.MM.YY',
        d1m1y4_full_stop TYPE ty_date_format VALUE 'D.M.YYYY',
        d1m1y2_full_stop TYPE ty_date_format VALUE 'D.M.YY',
        m2d2y4_minus     TYPE ty_date_format VALUE 'MM-DD-YYYY',
        m2d2y2_minus     TYPE ty_date_format VALUE 'MM-DD-YY',
        m1d1y4_minus     TYPE ty_date_format VALUE 'M-D-YYYY',
        m1d1y2_minus     TYPE ty_date_format VALUE 'M-D-YY',
        d2m2y4_minus     TYPE ty_date_format VALUE 'DD-MM-YYYY',
        d2m2y2_minus     TYPE ty_date_format VALUE 'DD-MM-YY',
        d1m1y4_minus     TYPE ty_date_format VALUE 'D-M-YYYY',
        d1m1y2_minus     TYPE ty_date_format VALUE 'D-M-YY',
      END OF c_date_format .
endinterface.
