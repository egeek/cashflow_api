# CashFlowsApi::PaymentJob

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**reference** | **Integer** | A unique reference of this payment job. | [optional] 
**create_date_time_utc** | **DateTime** | The date and time this payment job has been created. | [optional] 
**type** | [**PaymentJobType**](PaymentJobType.md) |  | [optional] 
**trace_reference** | **Integer** | A reference to a trace object which will trace all actions executed on this payment. | [optional] 
**configuration_id** | **String** | The id of the site or service the payment job is associated with. | [optional] 
**domain** | **String** | The domain where the request arrived on. | [optional] 
**locale** | [**Locale**](Locale.md) |  | [optional] 
**time_zone** | **String** | The time zone of the target audience of this payment job. | [optional] 
**order** | [**Order**](Order.md) |  | [optional] 
**order_history** | [**Array&lt;Order&gt;**](Order.md) | The history of updated orders. | [optional] 
**parent_payment_job_reference** | **Integer** | A reference to the parent payment job. | [optional] 
**payment_methods_to_use** | [**Array&lt;PaymentMethod&gt;**](PaymentMethod.md) | A list of payment methods (for example iDeal, PayPal, AfterPay) to enable for this request.  If none are supplied, all configured and applicable payment methods will be used. | [optional] 
**display_url** | **String** | A URL that is shown in the portal to the receiver.  This can be used to store a link to an order in the receiver&#x27;s order system for easy navigation. | [optional] 
**currency** | [**Currency**](Currency.md) |  | [optional] 
**amount_to_collect** | **Float** | The amount to collect in this payment job. | [optional] 
**amount_collected** | **Float** | The amount collected in this payment job so far.  Only set after a payment is final (reversals such as chargebacks aside), for instance after a card capture. | [optional] 
**paid_amount** | **Float** | The amount that the payer has has paid, which includes surcharge amounts.  Only set after a payment is final (reversals such as chargebacks aside), for instance after a card capture. | [optional] 
**paid_date_time_utc** | **DateTime** | The date and time the total to amount to collect has been paid.  Null if the payment job is not fully paid. | [optional] 
**expiration_date_time_utc** | **DateTime** | The date and time the payment job expires and is no longer valid. | [optional] 
**due_date_time_utc** | **DateTime** | The date and time the payment job is due for processing.  Null if the payment job is not due for processing. | [optional] 
**last_update_time_utc** | **DateTime** | The date and time of the last update to the payment job. | [optional] 
**last_processed_time_utc** | **DateTime** | The date and time this payment job was processed for the last time. | [optional] 
**flags** | [**PaymentJobFlags**](PaymentJobFlags.md) |  | [optional] 
**attributes** | [**PaymentJobAttributes**](PaymentJobAttributes.md) |  | [optional] 
**payment_status** | [**PaymentStatus**](PaymentStatus.md) |  | [optional] 
**payments** | [**Array&lt;Payment&gt;**](Payment.md) | List of payments that are part of this payment job. | [optional] 
**recurrence_criteria** | [**RecurrenceCriteria**](RecurrenceCriteria.md) |  | [optional] 

