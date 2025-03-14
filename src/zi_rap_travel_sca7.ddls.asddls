@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel data'


define root view entity ZI_RAP_TRAVEL_SCA7
  as select from zarap_travel_sca as Travel
    
  composition [0..*] of ZI_RAP_BOOKING_SCA7      as _Booking
  
  association [0..1] to /DMO/I_Agency            as _Agency        on $projection.Agency_Id = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer          as _Customer      on $projection.Customer_Id = _Customer.CustomerID
  association [0..1] to I_Currency               as _Currency      on $projection.Currency_Code = _Currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.Overall_Status = _OverallStatus.OverallStatus

{
  key travel_id       as Travel_Id,
      agency_id       as Agency_Id,
      customer_id     as Customer_Id,
      begin_date      as Begin_Date,
      end_date        as End_Date,
      @Semantics.amount.currencyCode: 'Currency_Code'
      booking_fee     as Booking_Fee,
      @Semantics.amount.currencyCode: 'Currency_Code'
      total_price     as Total_Price,
      currency_code   as Currency_Code,
      description     as Description,
      overall_status  as Overall_Status,
      @Semantics.user.createdBy: true
      created_by      as Created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at      as Created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by as Last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as Last_changed_at,

      _OverallStatus,
      _Booking,
      _Currency,
      _Customer,
      _Agency

}
