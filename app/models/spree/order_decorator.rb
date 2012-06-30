Spree::Order.class_eval do
  belongs_to :store
  scope :by_store, lambda { |store| where(:store_id => store.id) }
  
  def deliver_order_confirmation_email
    begin
      Spree::OrderMailer.confirm_email(self).deliver
      Spree::OrderMailer.confirm_email_to_stores(self).deliver
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end
  
  
  
end
