CLASS zcl_generate_demo_data_sca7 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_demo_data_sca7 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " delete existing entries in the database table
    DELETE FROM zarap_travel_sca.
    DELETE FROM zarap_book_sca7.
    DELETE FROM zarap_bksup_sca7.

    INSERT zarap_travel_sca
      FROM (
    SELECT * FROM /dmo/travel_m
     WHERE total_price <> 0 ).

    IF sy-subrc IS INITIAL.
      INSERT zarap_book_sca7
      FROM (
      SELECT FROM zarap_travel_sca AS a JOIN /dmo/booking_m AS b ON a~travel_id = b~travel_id
             FIELDS a~travel_id,
                    b~booking_id  ,
                    b~booking_date,
                    b~customer_id     ,
                    carrier_id        ,
                    connection_id     ,
                    flight_date       ,
                    flight_price      ,
                    b~currency_code   ,
                    booking_status    ,
                    b~last_changed_at ).

      IF sy-subrc IS INITIAL.

        INSERT zarap_bksup_sca7
          FROM (
            SELECT FROM zarap_book_sca7 AS c JOIN /dmo/booksuppl_m AS m ON c~travel_id  = m~travel_id
                                                                       AND c~booking_id = m~booking_id
                   FIELDS m~travel_id          ,
                          m~booking_id         ,
                          booking_supplement_id,
                          supplement_id        ,
                          price                ,
                          m~currency_code      ,
                          m~last_changed_at    ).

        IF sy-subrc IS INITIAL.
          COMMIT WORK.
        ENDIF.
      ENDIF.

      IF sy-subrc IS NOT INITIAL.
        out->write( | ocorreu um erro | ).

      ELSE.
        out->write( 'Travel e Booking and Supply demo data inserted.' ).
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
