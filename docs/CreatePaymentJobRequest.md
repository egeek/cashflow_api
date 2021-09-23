# SwaggerClient::CreatePaymentJobRequest

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | [**PaymentJobType**](PaymentJobType.md) |  | [optional] 
**locale** | [**Locale**](Locale.md) |  | [optional] 
**time_zone** | **String** | The time zone of the intented audience of the payment job. | [optional] 
**order** | [**UpdateOrderRequest**](UpdateOrderRequest.md) |  | [optional] 
**parent_payment_job_reference** | **Integer** | A reference to the parent payment job. | [optional] 
**payment_methods_to_use** | [**Array&lt;GatewayPaymentMethod&gt;**](GatewayPaymentMethod.md) | A list of payment methods (for example iDeal, PayPal, AfterPay) to enable for this request.  If none are supplied, all configured and applicable payment methods will be used. | [optional] 
**parameters** | [**CreatePaymentJobRequestParameters**](CreatePaymentJobRequestParameters.md) |  | [optional] 
**options** | [**Array&lt;PaymentJobOption&gt;**](PaymentJobOption.md) | Additional options used to steer payment job related flows. | [optional] 
**preparation_ids** | **Array&lt;String&gt;** | List of preparation ids, used to store some values to be used in this payment job create request. | [optional] 
**display_url** | **String** | A URL that is shown in the portal to the receiver.  This can be used to store a link to an order in the receiver&#x27;s order system for easy navigation. | [optional] 
**currency** | [**Currency**](Currency.md) |  | 
**amount_to_collect** | **Float** | The amount to collect in this payment job.  This amount is initially supplied by the instantiator of the payment request.  The amount which is actually collected is the sum of the amount to collect and the surcharge amount together. | [optional] 
**expiration_date_time_utc** | **DateTime** | The date and time the payment job expires and is no longer valid.  If not supplied, the payment job will expire after six months after creation. | [optional] 
**recurrence_criteria** | [**RecurrenceCriteria**](RecurrenceCriteria.md) |  | [optional] 

