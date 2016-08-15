#!/usr/bin/env ../../sounz/script/runner

include FailedOrdersHelper

# Script that:
# checks if there are any DPS Pxpay successful transactions that failed to be generated as an order in E-commerce part of the system
# sends an email notification to E-commerce admin with the info on the failed orders

# we select only APPROVED (successful) transactions that do not have an order id
failed_order_creation_records = FailedOrdersHelper.get_failed_order_creation_records

#script_last_run = 1.day.ago

error = false

if !failed_order_creation_records.blank?

  # generate email to SOUNZ administrators
  # get recipients from 'settings' table
  recipients = Setting.get_value(Setting::FAILED_ORDERS_NOTIFICATION_RECIPIENT).split(',')
  error_recipients = Setting.get_value(Setting::ERROR_RECIPIENT).split(',')

  # get sender from 'settings' table
  notification_sender = Setting.get_value(Setting::SUBMISSION_NOTIFICATION_SENDER_EMAIL)

  email_subject = "SOUNZ Online failed orders as of " + Time.now.strftime("%Y-%m-%d %H:%M")

  # email content
  email_content_html = ''

  count = 1

  failed_order_creation_records.each do |record|
    dps_pxpay_id = record['dps_pxpay_id']
    merchant_ref = record['merchant_ref']
    # transaction total amount
    total_amount = record['total_amount']
    # customer's login
    login = FailedOrdersHelper.get_transaction_login(merchant_ref)

    if !login.blank?

      # make sure that that user is not still logged in to zencart
      if !FailedOrdersHelper.is_user_online?(login.login_id)

        transaction_timestamp = FailedOrdersHelper.get_transaction_timestamp(merchant_ref)

        # temp solution until Fix Failed Order UI is implemented
        # to avoid sending notifications on the transactions that were already
        # flagged for admin
        # this is taking into account that script is run daily
       # if (DateTime::parse(transaction_timestamp).to_time > script_last_run)
          transaction_date_Ymd = transaction_timestamp[0...-6]

          customer_name  = Login.get_name(login.id)
          customer_email = login.username
          customer_url   = login.get_contact_url

          order_fix_url  = "http://#{Setting.get_value(Setting::WEBSITE_URL)}/failed_orders/new_order/#{dps_pxpay_id}"

          customer_selected_products_array = FailedOrdersHelper.get_cart_products_ui_format(login.login_id, transaction_date_Ymd)

          email_content_html += "#{count.to_s}. #{customer_name} (#{customer_email}): <a href='#{customer_url}'>#{customer_url}</a><br><br>"

          email_content_html += "Transaction Total: $#{total_amount}<br><br>"
          email_content_html += "Merchant Ref: #{merchant_ref}<br><br>"
          email_content_html += "Products in Shopping Cart:<br><br>"

          customer_selected_products_array.each do |selected_product|
            email_content_html += selected_product['ui_details'] + "<br>"
          end

          email_content_html += "<br>"

          email_content_html += "This order can be fixed on: <a href='#{order_fix_url}'>#{order_fix_url}</a><br><br><br>"
          count +=1
      #  end
      end
    else
      # error situation - notify Catalyst Admin as well
      error = true

      email_content_html += "An ERROR happened when processing the record with the merchant_ref #{merchant_ref}.<br>"

    end

  end

  # finally send notification
  if !email_content_html.blank?
    # replace any html tags to get a plain text version
    email_content_text = email_content_html.gsub("<br>", "\r\n").gsub(/<(\/|\s)*[^>]*>/,'')

    recipients = recipients + error_recipients if error

    recipients.each do |recipient|
      mailing = Mailing::deliver_mail_mailout(recipient, notification_sender, email_subject, email_content_html, email_content_text)
      #puts mailing
    end
  end

end