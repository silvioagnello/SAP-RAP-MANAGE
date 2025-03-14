@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Travel'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_rap_travel_sca7
  provider contract transactional_query
  as projection on ZI_RAP_TRAVEL_SCA7
{
  key Travel_Id,
      Agency_Id,
      Customer_Id,
      Begin_Date,
      End_Date,
      @Semantics.amount.currencyCode: 'Currency_Code'
      Booking_Fee,
      @Semantics.amount.currencyCode: 'Currency_Code'
      Total_Price,
      Currency_Code,
      Description,
      Overall_Status,
      Created_by,
      Created_at,
      Last_changed_by,
      Last_changed_at,
    
      /* Associations */
      _Booking : redirected to composition child zc_rap_book_sca7,
      _Agency,
      _Currency,
      _Customer,
      _OverallStatus
}
