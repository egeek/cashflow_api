# CashFlowsApi::OrderLine

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**line_number** | **Integer** | A number, unique to an order, to determine the order of the order lines. | [optional] 
**type** | [**OrderLineType**](OrderLineType.md) |  | [optional] 
**sku_code** | **String** | A (unique) code that refers to a particular stock keeping unit. | [optional] 
**name** | **String** | The name of the product or service. | 
**description** | **String** | A description of the product or service. | [optional] 
**quantity** | **Float** | The ordered quantity. | [optional] 
**unit_price_excl_vat** | **Float** | Unit price excluding value-added tax (VAT).  &lt;br&gt;Note: either one or both unit prices must be specified. | [optional] 
**unit_price_incl_vat** | **Float** | Unit price including value-added tax (VAT).  &lt;br&gt;Note: either one or both unit prices must be specified. | [optional] 
**vat_percentage** | **Float** | Applied VAT percentage. | [optional] 
**vat_percentage_label** | **String** | VAT percentage to display. | [optional] 
**discount_percentage_label** | **String** | Discount percentage to display. | [optional] 
**total_line_amount** | **Float** | Total order line amount.  Including VAT if the unit price including VAT is specified, otherwise excluding VAT. | [optional] 
**url** | **String** | A URL that is shown in the portal to the receiver.  This can be used to store a link to a product for easy navigation. | [optional] 

