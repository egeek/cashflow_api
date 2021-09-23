# SwaggerClient::Address

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** | A prefix or suffix added to someone&#x27;s name in certain contexts.  For example \&quot;Mr.\&quot; or \&quot;Ms.\&quot;/\&quot;Mrs.\&quot; for an adult man or woman.  This value is used \&quot;as is\&quot;, regardless of the locale specified in the payment job. | [optional] 
**first_name** | **String** | The given name of the addressee. | [optional] 
**middle_name** | **String** | The middle part of the name of the addressee.  This is the portion of a personal name that is written between the person&#x27;s given name and their surname. | [optional] 
**last_name** | **String** | The last part of the name of the addressee.  This usually is the person&#x27;s surname. | [optional] 
**country_iso3166_alpha2** | [**Country**](Country.md) |  | [optional] 
**address_line1** | **String** | Primary address information, such as street name and house number. | [optional] 
**address_line2** | **String** | Additional address information, such as floor number or apartment number. | [optional] 
**zip_code** | **String** | The zip or postal code. | [optional] 
**city** | **String** | The name of the city. | [optional] 
**state_province** | **String** | The name of the state or province. | [optional] 
**phone_number1** | **String** | Primary telephone number of the addressee. | [optional] 
**phone_number1_type** | [**PhoneNumberType**](PhoneNumberType.md) |  | [optional] 
**phone_number2** | **String** | Secondary telephone number of the addressee. | [optional] 
**phone_number2_type** | [**PhoneNumberType**](PhoneNumberType.md) |  | [optional] 
**organisation** | **String** | Name of the company or organisation, if the address is a company or organisation. | [optional] 
**department** | **String** | Name of the department, if the address is a company or organisation. | [optional] 

