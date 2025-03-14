@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Booking'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_rap_book_sca7
  as projection on ZI_RAP_BOOKING_SCA7
{
  key Travel_Id,
  key Booking_Id,
      Booking_Date,
      Customer_Id,
      Carrier_Id,
      Connection_Id,
      Flight_Date,
      @Semantics.amount.currencyCode: 'Currency_Code'
      Flight_Price,
      Currency_Code,
      booking_status,
      last_changed_at,
      
      /* Associations */
      _BookingStatus,
      _BookSupplement : redirected to composition child zc_rap_bksup_sca7,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent zc_rap_travel_sca7
}
