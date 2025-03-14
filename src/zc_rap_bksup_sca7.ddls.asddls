@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Supplement'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_rap_bksup_sca7
  as projection on ZI_RAP_BOOKSU_SCA7
{
  key Travel_Id,
  key Booking_Id,
  key BookingSupplement_Id,
      Supplement_Id,
      @Semantics.amount.currencyCode: 'Currency_Code'
      Price,
      Currency_Code,
      Last_Changed_At,
      
      /* Associations */
      _Booking: redirected to parent zc_rap_book_sca7,
      _Product,
      _SupplementText,
      _Travel
}
