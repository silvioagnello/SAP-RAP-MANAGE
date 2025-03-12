@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel data'


define root view entity ZI_RAP_TRAVEL_SCA7
  as select from /dmo/travel_m as Travel
  composition [0..*] of ZI_RAP_BOOKING_SCA7      as _Booking
  association [0..1] to /DMO/I_Agency            as _Agency        on $projection.AgencyId = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer          as _Customer      on $projection.CustomerId = _Customer.CustomerID
  association [0..1] to I_Currency               as _Currency      on $projection.CurrencyCode = _Currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.OverallStatus = _OverallStatus.OverallStatus

{
  key travel_id       as TravelId,
      agency_id       as AgencyId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      description     as Description,
      overall_status  as OverallStatus,
      @Semantics.user.createdBy: true
      created_by      as Createdby,
      @Semantics.systemDateTime.createdAt: true
      created_at      as Createdat,
      @Semantics.user.lastChangedBy: true
      last_changed_by as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as Lastchangedat,

      _OverallStatus,
      _Booking,
      _Currency,
      _Customer,
      _Agency

}
