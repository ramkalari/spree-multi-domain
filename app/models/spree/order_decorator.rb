Spree::Order.class_eval do
  belongs_to :store
  scope :by_store, lambda { |store| where(:store_id => store.id) }
  
  def deliver_order_confirmation_email
    begin
      Spree::OrderMailer.confirm_email(self).deliver
      line_items_by_store = self.line_items.group_by {|line_item| line_item.store_id}
      line_items_by_store.each do |key, value|
        Spree::OrderMailer.confirm_email_to_stores(key, self, value).deliver  
      end
      
    rescue Exception => e
      logger.error("#{e.class.name}: #{e.message}")
      logger.error(e.backtrace * "\n")
    end
  end
  
  
  
end
