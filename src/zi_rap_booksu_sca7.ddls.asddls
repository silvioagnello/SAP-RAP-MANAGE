@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supli data'

define view entity ZI_RAP_BOOKSU_SCA7
  as select from zarap_bksup_sca7 as BookingSupplement

  association        to parent ZI_RAP_BOOKING_SCA7 as _Booking        on  $projection.Travel_Id  = _Booking.Travel_Id
                                                                      and $projection.Booking_Id = _Booking.Booking_Id

  association [1..1] to ZI_RAP_TRAVEL_SCA7         as _Travel         on  $projection.Travel_Id = _Travel.Travel_Id
  association [1..1] to /DMO/I_Supplement          as _Product        on  $projection.Supplement_Id = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText      as _SupplementText on  $projection.Supplement_Id = _SupplementText.SupplementID

{
  key cast(travel_id as /dmo/travel_id preserving type)    as Travel_Id,
  key cast(booking_id as /dmo/booking_id preserving type ) as Booking_Id,
  key booking_supplement_id                                as BookingSupplement_Id,
      supplement_id                                        as Supplement_Id,
      @Semantics.amount.currencyCode: 'currency_code'
      price                                                as Price,
      currency_code                                        as Currency_Code,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at                                      as Last_Changed_At,

      /* Associations */
      _Travel,
      _Booking,
      _Product,
      _SupplementText
}
