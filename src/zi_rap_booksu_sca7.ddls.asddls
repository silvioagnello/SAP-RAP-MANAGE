@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supli data'

define view entity ZI_RAP_BOOKSU_SCA7
  as select from /dmo/booksuppl_m as BookingSupplement

  association        to parent ZI_RAP_BOOKING_SCA7 as _Booking        on  $projection.TravelId  = _Booking.TravelId
                                                                      and $projection.booking_id = _Booking.BookingId

  association [1..1] to ZI_RAP_TRAVEL_SCA7         as _Travel         on  $projection.TravelId = _Travel.TravelId
  association [1..1] to /DMO/I_Supplement          as _Product        on  $projection.supplement_id = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText      as _SupplementText on  $projection.supplement_id = _SupplementText.SupplementID

{
  key BookingSupplement.travel_id             as TravelId,
  key BookingSupplement.booking_id            ,
  key BookingSupplement.booking_supplement_id ,
      BookingSupplement.supplement_id         ,
      @Semantics.amount.currencyCode: 'currency_code'
      price,
      currency_code,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      BookingSupplement.last_changed_at       as LastChangedAt,

      /* Associations */
      _Travel,
      _Booking,
      _Product,
      _SupplementText
}
