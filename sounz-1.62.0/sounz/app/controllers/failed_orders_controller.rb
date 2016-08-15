class FailedOrdersController < ApplicationController

  include ApplicationHelper

  # New order for a successful payment transaction
  # to fix the failure during customer's online shopping
  def new_order
    @dps_pxpay_id = params[:id]
    @order = Order.new
    initialize_new_order
    if @merchant_ref.blank?
      flash[:error] = "That failed order transaction does not exist"
    end
  end

  # Create an order for that successful dps pxpay transaction without an order id assigned to it
  #
  # The process consists of several stages:
  #
  # 1. order creation                                       - zencartorders table
  #
  # 2. selected products processing, for each product:
  # order products creation                              - zencartorders_products table
  # order products attribute                             - zencartorders_products_attributes table
  # order products download (for download products only) - zencartorders_products_download table
  #
  # if a selected product is of 'SERVICE' class, appropriate membership is created for the customer's login
  # if a selected product is of 'LOAN' class, appropriate borrowed item record is created for that customer
  #
  # once an order product record is created, the product is deleted from customer's shopping cart
  #
  # 3. the created order id is assigned to the dps pxpay transaction
  #
  # if there are any errors during that multistage process, they are logged in errors array
  # and displayed to the editing user
  def create_new_order

    @dps_pxpay_id = params[:id]
    selected_products = params[:products][:ids] unless params[:products].blank?

    @order = Order.new(params[:order])

    if !params[:contactinfo].blank?

      @order.customers_street_address    = params[:contactinfo][:street]
      @order.customers_suburb            = params[:contactinfo][:suburb]
      @order.customers_city              = params[:contactinfo][:locality]
      @order.customers_postcode          = params[:contactinfo][:postcode]
      @order.customers_state             = ''
      @order.customers_state             = Region.find(params[:contactinfo][:region_id].to_i).region_name unless params[:contactinfo][:region_id].blank?
      @order.customers_country           = ''
      @order.customers_country           = Country.find(params[:contactinfo][:country_id].to_i).country_name unless params[:contactinfo][:country_id].blank?
      @order.customers_telephone         = params[:contactinfo][:phone_prefix] +  params[:contactinfo][:phone] + params[:contactinfo][:phone_extension]
      @order.customers_email_address     = params[:contactinfo][:email_1]
      @order.customers_address_format_id = 1 if params[:order][:customers_address_format_id].blank?

    end

    if !params[:delivery_contactinfo].values.join('').blank?

      @order.delivery_name               = params[:delivery_contactinfo][:name]
      @order.delivery_company            = params[:delivery_contactinfo][:company]
      @order.delivery_street_address     = params[:delivery_contactinfo][:street]
      @order.delivery_suburb             = params[:delivery_contactinfo][:suburb]
      @order.delivery_city               = params[:delivery_contactinfo][:locality]
      @order.delivery_postcode           = params[:delivery_contactinfo][:postcode]
      @order.delivery_state              = ''
      @order.delivery_state              = Region.find(params[:delivery_contactinfo][:region_id].to_i).region_name unless params[:delivery_contactinfo][:region_id].blank?
      @order.delivery_country            = ''
      @order.delivery_country            = Country.find(params[:delivery_contactinfo][:country_id].to_i).country_name unless params[:delivery_contactinfo][:country_id].blank?

    else
      # default to customers address
      @order.delivery_name               = @order.customers_name
      @order.delivery_company            = @order.customers_company
      @order.delivery_street_address     = @order.customers_street_address
      @order.delivery_suburb             = @order.customers_suburb
      @order.delivery_city               = @order.customers_city
      @order.delivery_postcode           = @order.customers_postcode
      @order.delivery_state              = @order.customers_state
      @order.delivery_country            = @order.customers_country

    end

    @order.delivery_address_format_id  = 1 if params[:order][:delivery_address_format_id].blank?

    if !params[:billing_contactinfo].values.join('').blank?

      @order.billing_name                = params[:billing_contactinfo][:name]
      @order.billing_company             = params[:billing_contactinfo][:company]
      @order.billing_street_address      = params[:billing_contactinfo][:street]
      @order.billing_suburb              = params[:billing_contactinfo][:suburb]
      @order.billing_city                = params[:billing_contactinfo][:locality]
      @order.billing_postcode            = params[:delivery_contactinfo][:postcode]
      @order.billing_state               = ''
      @order.billing_state               = Region.find(params[:billing_contactinfo][:region_id].to_i).region_name unless params[:billing_contactinfo][:region_id].blank?
      @order.billing_country             = ''
      @order.billing_country             = Country.find(params[:billing_contactinfo][:country_id].to_i).country_name unless params[:billing_contactinfo][:country_id].blank?

    else
      # default to customers address
      @order.billing_name                = @order.customers_name
      @order.billing_company             = @order.customers_company
      @order.billing_street_address      = @order.customers_street_address
      @order.billing_suburb              = @order.customers_suburb
      @order.billing_city                = @order.customers_city
      @order.billing_postcode            = @order.customers_postcode
      @order.billing_state               = @order.customers_state
      @order.billing_country             = @order.customers_country

    end

    @order.billing_address_format_id = 1 if params[:order][:billing_address_format_id].blank?

    @order.shipping_method = FailedOrdersHelper::SHIPPING_MODULES_ENABLED[@order.shipping_module_code]

    @order.last_modified   = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    errors = Array.new

    # zencartorders
    if !selected_products.blank? && @order.save
      orders_id = @order.id

      # zencartorders_total
      order_total = ActiveRecord::Base.connection.insert(
          "INSERT INTO zencartorders_total " +
          "(orders_id, title, text, value, class, sort_order) " +
          "VALUES(#{orders_id}, 'Total:', '$#{@order.order_total}', #{@order.order_total}, 'ot_total', 999)"
      )

      errors.push("Orders Total record failed to be created") unless order_total.to_i > 0

      # zencartorders_status_history
      order_status_history = ActiveRecord::Base.connection.insert(
          "INSERT INTO zencartorders_status_history " +
          "(orders_id, orders_status_id, date_added) " +
          "VALUES(#{orders_id}, #{@order.orders_status}, '#{@order.date_purchased}')"
      )

      errors.push("Orders Status History record failed to be created") unless order_status_history.to_i > 0

      # process each selected product
      selected_products.each do |selected_product|
        products_prid  = selected_product.gsub('products_', '')

        product = FailedOrdersHelper.get_product(products_prid.to_s.split(':')[0])
        product_class = product['products_class'] unless product.blank?

        # zencartorders_products
        orders_products_id = FailedOrdersHelper.create_orders_product(products_prid, orders_id, @order.customers_id, product)

        if orders_products_id.to_i > 0

          # zencartorders_products_attributes
          orders_products_attribute = FailedOrdersHelper.create_orders_products_attributes(orders_id, orders_products_id, products_prid)

          # zencartorders_products_download
          orders_products_download = FailedOrdersHelper.create_orders_products_download(orders_id, orders_products_id, products_prid)
          if orders_products_download.blank? && orders_products_download != false
            errors.push("Orders Products Download for product ID #{product['products_id']} #{product['products_name']} (#{product['products_model']}) failed to be created")
          end

          # memberships
          if product_class == 'SERVICE'
            # get the service
            service = SounzService.find(product['products_id'])

            # check whether that customer has already that type of membership
            # and get the one with the latest expiry date
            current_membership = Membership.find(:first, :select => 'expiry_date',
               :conditions => ['member_type_id =? AND login_id=?', service.member_type_id, @order.customers_id])

            start_date = Time.now
            start_date = current_membership['expiry_date'] unless current_membership.blank?

            expiry_date = start_date + service.subscription_duration_hash[:number].to_i.send(service.subscription_duration_hash[:interval])

            membership = Membership.create(
                              :login_id => @order.customers_id,
                              :member_type_id => service.member_type_id,
                              :expiry_date => expiry_date,
                              :pending_payment => false,
                              :loan_count => service.subscription_item_count.to_i,
                              :sounz_service_id => service.sounz_service_id,
                              :zencart_order_id => @order.orders_id
            )

            errors.push("Membership #{service.sounz_service_name} failed to be created") if membership.blank?

          elsif product_class.starts_with?('LOAN_')
            # get any item of that type
            # which one does not matter as we need an item id only to create a reserved borrowed item record
            # SOUNZ admin will manually assign an item they want from Borrowed Items UI
            loan_entity = product_class.split('_')[1]
            if loan_entity == "MANIFESTATION"
              item_type_id = ItemType::MUSIC_LIBRARY_ITEM.item_type_id
              item = Item.find(:first, :conditions => ['manifestation_id =? AND item_type_id =?', product['manifestation_id'], item_type_id])
            elsif loan_entity == "RESOURCE"
              item_type_id = ItemType::RESOURCE_LIBRARY_ITEM.item_type_id
              item = Item.find(:first, :conditions => ['resource_id =? AND item_type_id =?', product['manifestation_id'], item_type_id])
            end

            # create reserved borrowed item record
            borrowed_item = BorrowedItem.create( 
             :item_id => item.item_id,
             :hired_out => false,
             :date_borrowed => Time.now,
             :login_id => @order.customers_id,
             :date_due => (Time.now + 90.days),
             :active => true,
             :reserved => true
            )
            if borrowed_item.blank?
              errors.push("Borrowed Item record failed to be created")
            else
              # decrement loan_count for a library subcsription membership
              membership = Membership.get_subscription_item_count_membership(Login.find(@order.customers_id), 'library')
              membership.decrease_loan_count(1) unless membership.blank?
            end
          end


            # delete processed record from zencartcustomers_basket
            basket_record = ActiveRecord::Base.connection.delete(
               "DELETE FROM zencartcustomers_basket 
                  WHERE products_id = '#{products_prid}' 
                    AND customers_id = #{@order.customers_id}"
            )

          else
            errors.push("Product ID #{product['products_id']} #{product['products_name']} (#{product['products_model']}) failed to be added to the order no #{orders_id}")
          end #if !orders_products_id.blank?

        end #selected_products.each do |product|

        # update zencartdps_pxpay with order_id
        zencartdps_pxpay_record = ActiveRecord::Base.connection.update(
            "UPDATE zencartdps_pxpay SET order_id = #{orders_id} WHERE dps_pxpay_id = #{@dps_pxpay_id}"
        )
        errors.push("DPS Pxpay record #{dps_pxpay_id} failed to be updated with the order no #{orders_id}") unless zencartdps_pxpay_record > 0

        flash[:notice] = "The order was re-created"

        flash[:error]  = "ERRORS: #{errors.join('<br/>')}" unless errors.blank?

        redirect_to :action => :show_order, :id => orders_id

      else
        initialize_new_order
        if selected_products.blank?
          @order.valid? # validate Order object to get all validation errors
          @order.errors.add_to_base(" There is no products selected")
        end
        render :action => :new_order
      end

  end

  def initialize_new_order

    failed_order_creation_record = ActiveRecord::Base.connection.select_one(
        "SELECT merchant_ref, total_amount 
           FROM zencartdps_pxpay
             WHERE order_id IS NULL
               AND success = 1
               AND response_text = 'APPROVED'
               AND dps_pxpay_id = #{@dps_pxpay_id}"
    )

    if !failed_order_creation_record.blank?
      @merchant_ref = failed_order_creation_record['merchant_ref']
      # transaction total amount
      @total_amount = failed_order_creation_record['total_amount']
      # customer's login
      @customer_login = FailedOrdersHelper.get_transaction_login(@merchant_ref)

      if !@customer_login.blank?

        transaction_timestamp = FailedOrdersHelper.get_transaction_timestamp(@merchant_ref)
        # timestamp in postgres format
        @transaction_pg_timestamp = DateTime::parse(transaction_timestamp).to_time

        # format for querying zencartcustomers_basket customers_basket_date_added field
        transaction_date_Ymd = transaction_timestamp[0...-6]

        @customer_name     = Login.get_name(@customer_login.id)
        @customer_username = @customer_login.username
        @customer_url      = @customer_login.get_contact_url

        unless params[:contactinfo].blank?
          @contactinfo = Contactinfo.new(params[:contactinfo])
        else
          @contactinfo = @customer_login.get_ecommerce_contactinfo(get_user.login_id)
        end

        unless params[:delivery_contactinfo].blank?
          @delivery_contactinfo = Contactinfo.new(params[:delivery_contactinfo])
        end

        unless params[:billing_contactinfo].blank?
          @billing_contactinfo = Contactinfo.new(params[:billing_contactinfo])
        end

        unless params[:products].blank?
          @checked_products = params[:products][:ids]
        else
          @checked_products = Array.new
        end
  
        @selected_products = FailedOrdersHelper.get_cart_products_ui_format(@customer_login.login_id, transaction_date_Ymd)

        # Ecommerce currently supports only default currency
        @currency = ActiveRecord::Base.connection.select_one(
             "SELECT configuration_value 
                FROM zencartconfiguration 
               WHERE configuration_key = 'DEFAULT_CURRENCY'"
        )['configuration_value']

        # FIXME hard-coded
        @currency_value = 1.00
        @order_tax = 0.00

        # FIXME hard-coded payment module
        # but this controller is written especially for that method only
        @payment_method      = 'Secure online Credit Card transaction using Visa or Mastercard via DPS Payment Express'
        @payment_module_code = 'dps_pxpay'

      end

    end
  end

  def show_order
    @order = Order.find(params[:id])

    @order_products = ActiveRecord::Base.connection.select_all(
      "SELECT products_id, products_model, products_quantity, product_is_free, products_name, final_price
         FROM zencartorders_products WHERE orders_id = #{@order.orders_id}"
    )

  end

  def edit_order

  end

  def update_order

  end

  # 
  # Cancel transaction by setting its 'success' field to false
  # to allow administrators to deal with the reversed transactions
  # WR#57859
  def cancel_transaction
    @dps_pxpay_id = params[:id]
    zencartdps_pxpay_record = ActiveRecord::Base.connection.update(
            "UPDATE zencartdps_pxpay SET success = 0, response_text = '' WHERE dps_pxpay_id = #{@dps_pxpay_id}"
    )
    if zencartdps_pxpay_record > 0
      flash[:notice] = 'The transaction was cancelled'
    else
      flash[:error]  = 'An error happened. The transaction was not cancelled'
    end

    redirect_to :action => :new_order, :id => @dps_pxpay_id
  end
end