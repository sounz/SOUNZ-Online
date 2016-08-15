# 
# Methods for processing DPS Pxpay successful transactions 
# that failed to be generated as an order in E-commerce part of the system
#
module FailedOrdersHelper

  include ActionView::Helpers::NumberHelper

  # as those values are defined in Ecommerce (zencart modules)
  # and not kept in the db table
  # we have to hard-coded them here once again
  # newly enabled modules should be added to this hash
  SHIPPING_MODULES_ENABLED = { 
    "freeshipper" => "Free Shipping",
    "storepickup" => "Store Pickup",
    "table"       => "NZ Standard",
    "table2"      => "NZ Courier",
    "zones"       => "International Airmail"
  }

  def self.order_statuses
    statuses  = ActiveRecord::Base.connection.execute("SELECT orders_status_name, orders_status_id FROM zencartorders_status")
    @statuses = Array.new

    for status in statuses
      @statuses << [status['orders_status_name'], status['orders_status_id'].to_i]
    end

    return @statuses

  end

  # Get APPROVED (successful) transactions that do not have an order id
  def self.get_failed_order_creation_records
    failed_order_creation_records = ActiveRecord::Base.connection.select_all(
        "SELECT dps_pxpay_id, merchant_ref, total_amount 
           FROM zencartdps_pxpay
             WHERE order_id IS NULL
               AND success = 1
               AND response_text = 'APPROVED'"
    )

    return failed_order_creation_records

  end

  #
  # Return the transaction login
  # @param merchant_ref from zencartdps_pxpay table in the format: 
  # STORE_NAME + '-' + login_id/customers_id + '-' + transaction timestamp
  #
  def self.get_transaction_login(merchant_ref)
    login_id = merchant_ref.split('-')[1]

    login = Login.find(login_id.to_i)

    return login
  end

  #
  # Return the transaction timestamp
  # @param merchant_ref from zencartdps_pxpay table in the format: 
  # STORE_NAME + '-' + login_id/customers_id + '-' + transaction timestamp
  #
  def self.get_transaction_timestamp(merchant_ref)
    transaction_timestamp = merchant_ref.split('-')[2]

    return transaction_timestamp
  end

  # Return true if the user is online
  def self.is_user_online?(login_id)

    result = ActiveRecord::Base.connection.select_one("SELECT customer_id FROM zencartwhos_online WHERE customer_id = #{login_id}")

    return result.blank? ? false : true
  end

  #
  # Return products that were put into customer's shopping cart
  # before the payment took place as an array with products_id
  # and product details such as quantity, title, moneyworks code
  # and price
  #
  def self.get_cart_products_ui_format(login_id, transaction_date_Ymd)

    selected_products_array = Array.new

    # get products that were put into customer's shopping cart
    # before the payment took place
    selected_products_records = ActiveRecord::Base.connection.select_all(
           "SELECT products_id, customers_basket_quantity
               FROM zencartcustomers_basket
                   WHERE customers_id=#{login_id}
                     AND customers_basket_date_added <= '#{transaction_date_Ymd}'"
    )

    selected_products_records.each do |selected_product_record|
      products_id    = selected_product_record['products_id'].split(':')[0] # workaround for downloads products_ids

      quantity       = selected_product_record['customers_basket_quantity']

      products_records = ActiveRecord::Base.connection.select_all(
           "SELECT products_class, manifestation_id, products_model, products_price, products_name, product_is_free
               FROM sounz_zencart_products sp
                 LEFT JOIN sounz_zencart_products_description spd ON spd.products_id = sp.products_id
                   WHERE sp.products_id=#{products_id}"
      )

      products_records.each do |product_record|

        products_class = product_record['products_class']
        entity_mw_code = product_record['products_model']
        product_price  = product_record['products_price']
        product_price  = 0.0 if product_record['product_is_free'] == '1'
        entity_title   = product_record['products_name']

        ui_details_string = quantity.to_s + " X " + entity_title + " (" + entity_mw_code + "): $" + product_price.to_s

        selected_products_array.push('product_id' => products_id, 'ui_details' => ui_details_string)

      end

    end

    return selected_products_array
  end

  # Create record in zencartorders_products table for the particular order product
  # and return its id
  # @param products_prid (products_id in zencartcustomers_basket)
  # @param orders_id
  # @param customers_id
  # @param product array
  def self.create_orders_product(products_prid, orders_id, customers_id, product)
      products_id    = products_prid.split(':')[0] # workaround for downloads products_ids

      product_in_basket = ActiveRecord::Base.connection.select_one("
        SELECT customers_basket_quantity FROM zencartcustomers_basket
          WHERE customers_id = #{customers_id} AND products_id = '#{products_prid}'
      ")

      if product_in_basket.blank?
        return
      end

      #product = FailedOrdersHelper.get_product(products_id)

      if product.blank?
        return
      end

      products_price = product['products_price']
      products_price = 0.0 if product['product_is_free'] == '1'
=begin

                                                Table "public.zencartorders_products"
            Column            |         Type          |                                  Modifiers                                   
------------------------------+-----------------------+------------------------------------------------------------------------------
 orders_products_id           | integer               | not null default nextval('orders_products_orders_products_id_seq'::regclass)
 orders_id                    | integer               | not null default 0
 products_id                  | integer               | not null default 0
 products_model               | character varying(32) | 
 products_price               | numeric(15,4)         | not null default 0.0000
 final_price                  | numeric(15,4)         | not null default 0.0000
 products_tax                 | numeric(7,4)          | not null default 0.0000
 products_quantity            | double precision      | not null default (0)::double precision
 onetime_charges              | numeric(15,4)         | not null default 0.0000
 products_priced_by_attribute | smallint              | not null default (0)::smallint
 product_is_free              | smallint              | not null default (0)::smallint
 products_discount_type       | smallint              | not null default (0)::smallint
 products_discount_type_from  | smallint              | not null default (0)::smallint
 products_prid                | text                  | not null
 products_name                | text                  | 
Indexes:
    "zencartorders_products_pkey" PRIMARY KEY, btree (orders_products_id)
    "orders_products_1_idx" btree (orders_id, products_id)

=end
      orders_product = ActiveRecord::Base.connection.insert(
          "INSERT INTO zencartorders_products (
             orders_id,
             products_id,
             products_model,
             products_price,
             final_price,
             products_quantity,
             products_priced_by_attribute,
             product_is_free,
             products_discount_type,
             products_discount_type_from,
             products_prid,
             products_name
           ) VALUES (
             #{orders_id},
             #{products_id},
             '#{product['products_model']}',
             #{products_price},
             #{products_price},
             #{product_in_basket['customers_basket_quantity']},
             #{product['products_priced_by_attribute']},
             #{product['product_is_free']},
             #{product['products_discount_type']},
             #{product['products_discount_type_from']},
             '#{products_prid}',
             '#{product['products_name']}'
           )"
       )
       return orders_product

  end

  # Create record in zencartorders_products_attributes table for the particular order product
  # and return its id
  # @param orders_id
  # @param orders_products_id
  # @param products_prid (products_id in zencartcustomers_basket)
  def self.create_orders_products_attributes(orders_id, orders_products_id, products_prid)

      products_id    = products_prid.split(':')[0] # workaround for downloads products_ids

      product_attribute = ActiveRecord::Base.connection.select_one(
        "SELECT products_options_name,
                products_options_values_name,
                options_values_price,
                price_prefix,
                product_attribute_is_free,
                products_attributes_weight,
                products_attributes_weight_prefix,
                attributes_discounted,
                attributes_price_base_included,
                attributes_price_onetime,
                attributes_price_factor,
                attributes_price_factor_offset,
                attributes_price_factor_onetime,
                attributes_price_factor_onetime_offset,
                attributes_qty_prices,
                attributes_qty_prices_onetime,
                attributes_price_words,
                attributes_price_words_free,
                attributes_price_letters,
                attributes_price_letters_free,
                options_id,
                options_values_id
          FROM sounz_zencart_product_attributes zpa
            LEFT JOIN zencartproducts_options_values zov ON zpa.options_values_id = zov.products_options_values_id
            LEFT JOIN zencartproducts_options zo ON zpa.options_id = zo.products_options_id
          WHERE products_id = #{products_id}"
        )

      #RAILS_DEFAULT_LOGGER.debug "DEBUG: product_attribute #{product_attribute}"
      if product_attribute.blank?
        return
      end

      products_attributes_weight = product_attribute['products_attributes_weight'].to_i
=begin

                                                          Table "public.zencartorders_products_attributes"
                 Column                 |         Type          |                                             Modifiers                                              
----------------------------------------+-----------------------+----------------------------------------------------------------------------------------------------
 orders_products_attributes_id          | integer               | not null default nextval('orders_products_attributes_orders_products_attributes_id_seq'::regclass)
 orders_id                              | integer               | not null default 0
 orders_products_id                     | integer               | not null default 0
 products_options                       | character varying(32) | not null default ''::character varying
 products_options_values                | bytea                 | not null
 options_values_price                   | numeric(15,4)         | not null default 0.0000
 price_prefix                           | character(1)          | not null default ''::bpchar
 product_attribute_is_free              | smallint              | not null default (0)::smallint
 products_attributes_weight             | double precision      | not null default (0)::double precision
 products_attributes_weight_prefix      | character(1)          | not null default ''::bpchar
 attributes_discounted                  | smallint              | not null default (1)::smallint
 attributes_price_base_included         | smallint              | not null default (1)::smallint
 attributes_price_onetime               | numeric(15,4)         | not null default 0.0000
 attributes_price_factor                | numeric(15,4)         | not null default 0.0000
 attributes_price_factor_offset         | numeric(15,4)         | not null default 0.0000
 attributes_price_factor_onetime        | numeric(15,4)         | not null default 0.0000
 attributes_price_factor_onetime_offset | numeric(15,4)         | not null default 0.0000
 attributes_qty_prices                  | text                  | 
 attributes_qty_prices_onetime          | text                  | 
 attributes_price_words                 | numeric(15,4)         | not null default 0.0000
 attributes_price_words_free            | integer               | not null default 0
 attributes_price_letters               | numeric(15,4)         | not null default 0.0000
 attributes_price_letters_free          | integer               | not null default 0
 products_options_id                    | integer               | not null default 0
 products_options_values_id             | integer               | not null default 0
 products_prid                          | text                  | not null
Indexes:
    "zencartorders_products_attributes_pkey" PRIMARY KEY, btree (orders_products_attributes_id)
    "orders_products_attributes_1_idx" btree (orders_id, orders_products_id)

=end
      orders_product_attribute = ActiveRecord::Base.connection.insert(
          "INSERT INTO zencartorders_products_attributes (
             orders_id,
             orders_products_id,
             products_options,
             products_options_values,
             options_values_price,
             price_prefix,
             product_attribute_is_free,
             products_attributes_weight,
             products_attributes_weight_prefix,
             attributes_discounted,
             attributes_price_base_included,
             attributes_price_onetime,
             attributes_price_factor,
             attributes_price_factor_offset,
             attributes_price_factor_onetime,
             attributes_price_factor_onetime_offset,
             attributes_qty_prices,
             attributes_qty_prices_onetime,
             attributes_price_words,
             attributes_price_words_free,
             attributes_price_letters,
             attributes_price_letters_free,
             products_options_id,
             products_options_values_id,
             products_prid
           ) VALUES (
             #{orders_id},
             #{orders_products_id},
             '#{product_attribute['products_options_name']}',
             '#{product_attribute['products_options_values_name']}',
             #{product_attribute['options_values_price']},
             '#{product_attribute['price_prefix']}',
             #{product_attribute['product_attribute_is_free']},
             #{product_attribute['products_attributes_weight'].to_i},
             '#{product_attribute['products_attributes_weight_prefix']}',
             #{product_attribute['attributes_discounted']},
             #{product_attribute['attributes_price_base_included']},
             #{product_attribute['attributes_price_onetime']},
             #{product_attribute['attributes_price_factor']},
             #{product_attribute['attributes_price_factor_offset']},
             #{product_attribute['attributes_price_factor_onetime']},
             #{product_attribute['attributes_price_factor_onetime_offset']},
             '#{product_attribute['attributes_qty_prices']}',
             '#{product_attribute['attributes_qty_prices_onetime']}',
             #{product_attribute['attributes_price_words']},
             #{product_attribute['attributes_price_words_free']},
             #{product_attribute['attributes_price_letters']},
             #{product_attribute['attributes_price_letters_free']},
             #{product_attribute['options_id']},
             #{product_attribute['options_values_id']},
             '#{products_prid}'
           )"
       )

       RAILS_DEFAULT_LOGGER.debug "DEBUG: orders_product_attribute #{orders_product_attribute}"

       return orders_product_attribute

  end

  # Create record in zencartorders_products_download table for the particular order product if it is a download product
  # and return its id
  # @param orders_id
  # @param orders_products_id
  # @param products_prid (products_id in zencartcustomers_basket)
  def self.create_orders_products_download(orders_id, orders_products_id, products_prid)
    products_id    = products_prid.split(':')[0] # workaround for downloads products_ids

    product_download = ActiveRecord::Base.connection.select_one(
      "SELECT products_attributes_filename, products_attributes_filename_2, products_attributes_maxdays, products_attributes_maxcount
         FROM sounz_zencart_product_attributes_download INNER JOIN sounz_zencart_product_attributes USING (products_attributes_id)
           WHERE products_id = #{products_id}"
    )

    if product_download.blank?
      return false
    end

    orders_products_download = ActiveRecord::Base.connection.insert(
      "INSERT INTO zencartorders_products_download (
         orders_id,
         orders_products_id,
         orders_products_filename,
         download_maxdays,
         download_count,
         products_prid,
         orders_products_filename_2
       ) VALUES (
         #{orders_id},
         #{orders_products_id},
         '#{product_download['products_attributes_filename']}',
         #{product_download['products_attributes_maxdays']},
         #{product_download['products_attributes_maxcount']},
         '#{products_prid}',
         '#{product_download['products_attributes_filename_2']}'
       )"
     )

     return orders_products_download
  end

  # Return product hash
  def self.get_product(products_id)

    product = ActiveRecord::Base.connection.select_one("
        SELECT sounz_zencart_products.*, sounz_zencart_products_description.products_name
          FROM sounz_zencart_products INNER JOIN sounz_zencart_products_description USING (products_id)
            WHERE products_id = #{products_id}
    ")

    return product

  end

end