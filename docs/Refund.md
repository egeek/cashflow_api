# CashFlowsApi::Refund

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**reference** | **Integer** | A unique reference of this refund. | [optional] 
**create_date_time_utc** | **DateTime** | The date and time this refund has been created. | [optional] 
**refund_number** | **String** | A merchant supplied reference to this refund. | [optional] 
**status** | [**RefundStatus**](RefundStatus.md) |  | [optional] 
**amount_to_refund** | **Float** | The amount to refund in the currency specified in the payment job. | [optional] 
**converted_amount_to_refund** | **Float** | The amount to refund in the currency compatible with the selected method.  Equal to the amount to refund multiplied by the conversion rate.  If null, the amount to refund has not been converted and the amount to refund is used instead. | [optional] 
**converted_currency** | [**Currency**](Currency.md) |  | [optional] 
**conversion_rate** | **Float** | The conversion rate used for converting the amount to refund to the currency compatible with the selected method.  This rate multiplied by the amount to refund results in the converted amount to refund.  If null, the amount to refund has not been converted. | [optional] 
**steps** | [**Array&lt;RefundStep&gt;**](RefundStep.md) | A list of steps executed on this refund. | [optional] 
**attributes** | [**RefundAttributes**](RefundAttributes.md) |  | [optional] 

