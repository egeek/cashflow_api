# CashFlowsApi::Payment

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**reference** | **Integer** | A unique reference of this payment. | [optional] 
**create_date_time_utc** | **DateTime** | The date and time this payment has been created. | [optional] 
**payment_methods** | [**Array&lt;PaymentMethod&gt;**](PaymentMethod.md) | List of the payment method(s) to use.  This list will consist of multiple payment methods in case of a hosted payment, which are then reduced to exactly one payment method,  during a payment. This is done by asking the payer to make a choice what payment method he wants to use. | [optional] 
**status** | [**PaymentStatus**](PaymentStatus.md) |  | [optional] 
**last_error_report** | [**ErrorReport**](ErrorReport.md) |  | [optional] 
**abuse_report** | [**AbuseReport**](AbuseReport.md) |  | [optional] 
**amount_to_collect** | **Float** | The amount to collect in this payment in the currency specified in the payment job.  If left empty the entire amountToCollect of the payment job is used upon start of the payment. | [optional] 
**surcharge_amount** | **Float** | The amount which will be added to the originally supplied amount to collect. | [optional] 
**converted_total_amount** | **Float** | The total amount to be paid in this payment in the currency compatible with the selected payment method.  Equal to the amount to collect + surcharge amount, multiplied by the conversion rate.  If null, the total amount has not been converted and the amount to collect + surcharge amount is used instead. | [optional] 
**converted_currency** | [**Currency**](Currency.md) |  | [optional] 
**conversion_rate** | **Float** | The conversion rate used for converting the total amount to the currency compatible with the selected payment  method. If null, the amount to collect has not been converted. | [optional] 
**paid_amount** | **Float** | The amount that the payer has has paid to the receiver.  Only set after a payment is final (reversals such as chargebacks aside), for instance after a card capture. | [optional] 
**steps** | [**Array&lt;PaymentStep&gt;**](PaymentStep.md) | A list of steps executed on this payment. | [optional] 
**flags** | **Object** | Flags that apply to this payment.  They can either not be set or set with a true or false value. | [optional] 
**attributes** | [**PaymentAttributes**](PaymentAttributes.md) |  | [optional] 
**refunds** | [**Array&lt;Refund&gt;**](Refund.md) | List of refunds that are or will be executed on this payment. | [optional] 
**captures** | [**Array&lt;Capture&gt;**](Capture.md) | List of captures that are or will be executed on this payment. | [optional] 

