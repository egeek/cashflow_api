# SwaggerClient::Capture

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**reference** | **Integer** | A unique reference of this capture. | [optional] 
**create_date_time_utc** | **DateTime** | The date and time this capture has been created. | [optional] 
**status** | [**CaptureStatus**](CaptureStatus.md) |  | [optional] 
**amount_to_capture** | **Float** | The amount to capture in the currency specified in the payment job. | [optional] 
**converted_amount_to_capture** | **Float** | The amount to capture in the currency compatible with the selected method.  Equal to the amount to capture multiplied by the conversion rate.  If null, the amount to capture has not been converted and the amount to capture is used instead. | [optional] 
**converted_currency** | [**Currency**](Currency.md) |  | [optional] 
**conversion_rate** | **Float** | The conversion rate used for converting the amount to capture to the currency compatible with the selected method.  This rate multiplied by the amount to capture results in the converted amount to capture.  If null, the amount to capture has not been converted. | [optional] 
**is_final_capture** | **BOOLEAN** | Indicates that this is the last capture. | [optional] 
**attributes** | [**CaptureAttributes**](CaptureAttributes.md) |  | [optional] 

