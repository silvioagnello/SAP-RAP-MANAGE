@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking data'

define view entity ZI_RAP_BOOKING_SCA7
  as select from zarap_book_sca7  as Booking
  
  association        to parent ZI_RAP_TRAVEL_SCA7 as _Travel     on  $projection.Travel_Id = _Travel.Travel_Id
  composition [0..*] of ZI_RAP_BOOKSU_SCA7        as _BookSupplement
  
  association [1..1] to /DMO/I_Carrier            as _Carrier    on  $projection.Carrier_Id = _Carrier.AirlineID
  association [1..1] to /DMO/I_Customer           as _Customer   on  $projection.Customer_Id = _Customer.CustomerID
  association [1..1] to /DMO/I_Connection         as _Connection on  $projection.Carrier_Id    = _Connection.AirlineID
                                                                 and $projection.Connection_Id = _Connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookingStatus on  $projection.booking_status = _BookingStatus.BookingStatus
 
{
  key cast(travel_id as /dmo/travel_id preserving type) as Travel_Id,
  key booking_id                                        as Booking_Id,
      booking_date                                      as Booking_Date,
      customer_id                                       as Customer_Id,
      carrier_id                                        as Carrier_Id,
      connection_id                                     as Connection_Id,
      flight_date                                       as Flight_Date,
      @Semantics.amount.currencyCode: 'Currency_Code'
      flight_price                                      as Flight_Price,
      currency_code                                     as Currency_Code,
      booking_status,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at,

      _BookSupplement,
      _Travel,
      _Carrier,
      _Customer,
      _Connection,
      _BookingStatus

}
