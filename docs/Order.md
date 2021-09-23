# CashFlowsApi::Order

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**order_number** | **String** | The order number. | [optional] 
**note** | **String** | Additional comments or requests. | [optional] 
**create_date_time_utc** | **DateTime** | The date and time this order has been created. | [optional] 
**customer_reference** | **Integer** | A reference to the customer used for default billing address, billing identity and shipping address details. | [optional] 
**billing_address** | [**Address**](Address.md) |  | [optional] 
**billing_identity** | [**Identity**](Identity.md) |  | [optional] 
**shipping_address** | [**Address**](Address.md) |  | [optional] 
**order_lines** | [**Array&lt;OrderLine&gt;**](OrderLine.md) | List of order lines that that contain the order line details. | [optional] 

