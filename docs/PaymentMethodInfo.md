# SwaggerClient::PaymentMethodInfo

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**payment_method** | **String** | The payment method. | 
**logo** | **String** | The logo of this payment method. | [optional] 
**issuer_list** | [**Array&lt;Issuer&gt;**](Issuer.md) | List of supported issuers for this payment method. | [optional] 
**supports_tokenisation** | **BOOLEAN** | Flag that indicates whether or not the payment method supports tokenisation. | [optional] 
**tokenized_cards** | [**Array&lt;CardTokenData&gt;**](CardTokenData.md) | A list of cards that are tokenized. | [optional] 
**currencies** | [**Array&lt;Currency&gt;**](Currency.md) | Supported currencies for this payment method. | 
**surcharge_amount** | **Float** | Amount on top of the amount to collect, for the use of this payment method, including value-added tax. | [optional] 
**surcharge_amount_excl_vat** | **Float** | Amount on top of the amount to collect, for the use of this payment method, excluding value-added tax. | [optional] 
**surcharge_amount_vat** | **Float** | The amount of value-added tax in the surcharge amount. | [optional] 
**surcharge_vat_percentage** | **Float** | The surcharge vat percentage. | [optional] 
**description** | **String** | A description about this payment method. | [optional] 

