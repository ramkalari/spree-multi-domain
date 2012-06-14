object false
node(:count) { @stores.total_count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:pages) { @stores.num_pages }
child(@stores) do
  extends "spree/api/v1/stores/show"
end
