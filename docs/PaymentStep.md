# CashFlowsApi::PaymentStep

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**reference** | **Integer** | A unique reference of this payment step. | [optional] 
**create_date_time_utc** | **DateTime** | The date and time this payment step has been created. | [optional] 
**action** | [**PaymentStepAction**](PaymentStepAction.md) |  | [optional] 
**payment_methods** | [**Array&lt;PaymentMethod&gt;**](PaymentMethod.md) | List of the payment method(s) to use.  This list will consist of multiple payment methods in case of a hosted payment, which are then reduced to exactly one payment method,  during a payment. This is done by asking the payer to make a choice in what payment method he wants to use. | [optional] 
**status** | [**PaymentStatus**](PaymentStatus.md) |  | [optional] 
**amount_to_collect** | **Float** | The amount to collect in this payment in the currency specified in the payment job. | [optional] 

