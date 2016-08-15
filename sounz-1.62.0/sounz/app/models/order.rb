class Order < ActiveRecord::Base

  set_primary_key :orders_id
  set_sequence_name "orders_orders_id_seq"



=begin
  attr_accessor :orders_id,
              :customers_id,
              :customers_name,
              :customers_company,
              :customers_street_address,
              :customers_suburb,
              :customers_city,
              :customers_postcode,
              :customers_state,
              :customers_country,
              :customers_telephone,
              :customers_email_address,
              :customers_address_format_id,
              :delivery_name,
              :delivery_company,
              :delivery_street_address,
              :delivery_suburb,
              :delivery_city,
              :delivery_postcode,
              :delivery_state,
              :delivery_country,
              :delivery_address_format_id,
              :billing_name,
              :billing_company,
              :billing_street_address,
              :billing_suburb,
              :billing_city,
              :billing_postcode,
              :billing_state,
              :billing_country,
              :billing_address_format_id,
              :payment_method,
              :payment_module_code,
              :shipping_method,
              :shipping_module_code,
              :last_modified,
              :date_purchased,
              :orders_status,
              :currency,
              :currency_value,
              :order_total,
              :order_tax,
              :coupon_code,
              :paypal_ipn_id,
              :ip_address
=end
  def self.table_name() "zencartorders" end

  validates_presence_of :shipping_module_code,
                        :customers_street_address,
                        :customers_suburb,
                        :customers_city,
                        :customers_postcode,
                        :customers_country,
                        :customers_telephone,
                        :customers_email_address,
                        :customers_address_format_id,
                        :delivery_name,
                        :delivery_street_address,
                        :delivery_suburb,
                        :delivery_city,
                        :delivery_postcode,
                        :delivery_country,
                        :delivery_address_format_id,
                        :billing_name,
                        :billing_street_address,
                        :billing_suburb,
                        :billing_city,
                        :billing_postcode,
                        :billing_country,
                        :billing_address_format_id,

            :message => "cannot be empty"

  def set_mandatory_fields
     coupon_code   = ''  if self.coupon_code.blank?
     paypal_ipn_id = 0   if self.paypal_ipn_id.blank?
     ip_address    = ''  if self.ip_address.blank?

     return self
  end

end