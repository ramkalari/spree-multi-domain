object @product
attributes *product_attributes


child :variants_including_master => :variants do
  attributes *variant_attributes

  child :option_values => :option_values do
    attributes *option_value_attributes
  end
  
  
end

child :stores => :stores do
  extends "spree/api/v1/stores/show"
end


child :images => :images do
  extends "spree/api/v1/images/show"
end

child :option_types => :option_types do
  attributes *option_type_attributes

  child :option_values => :option_values do
    attributes *option_value_attributes
  end
end
