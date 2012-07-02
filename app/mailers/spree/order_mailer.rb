class Spree::OrderMailer < ActionMailer::Base
  helper "spree/base"

  def confirm_email(order, resend=false)
    @order = order
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Order Confirmation ##{order.number}"
    mail(:to => order.email,
           :subject => subject)
    #mail_params = {:to => order.email, :subject => subject}
    #mail_params[:from] = order.store.email if order.store.email.present?
    #mail(mail_params)
  end


  def confirm_email_to_stores(order, resend=false)
    # use group by to get line items for each store and store in into a hash
    # foe every key in the hash, load the store, get its email and send the lineitems to the template and the email
    @order = order
    line_items_by_store = order.line_items.group_by {|line_item| line_item.store_id}
    line_items_by_store.each do |key, value|
        @line_items = value
        subject = (resend ? "[RESEND] " : "")
        subject += "#{Spree::Config[:site_name]} New Order ##{order.number}"
        mail(:to => order.email,
             :subject => subject)

    end
  end

  def cancel_email(order, resend=false)
    @order = order
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} Cancellation of Order ##{order.number}"
    mail_params = {:to => order.email, :subject => subject}
    mail_params[:from] = order.store.email if order.store.email.present?
    mail(mail_params)
  end
end
