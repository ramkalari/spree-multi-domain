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


  def confirm_email_to_stores(store_id, order, line_items, resend=false)
    # use group by to get line items for each store and store in into a hash
    # foe every key in the hash, load the store, get its email and send the lineitems to the template and the email
        store_email = Store.find(store_id).email
        @line_items = line_items
        subject = (resend ? "[RESEND] " : "")
        subject += "#{Spree::Config[:site_name]} New Order ##{order.number}"
        mail(:to => store_email,
             :subject => subject)
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
