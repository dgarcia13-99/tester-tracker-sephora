resources :testers
get "/welcome" => "testers#welcome", as: :welcome
get "/makeup" => "testers#makeup", as: :makeup
get "/skincare" => "testers#skincare", as: :skincare
get "/hair" => "testers#hair", as: :hair
get "/fragrance" => "testers#fragrance", as: :fragrance
get "/manage_testers" => "testers#manage", as: :manage
patch "/trash/:id(.:format)" => "testers#trash", as: :trash
get "/trashed_testers" => "testers#trashed", as: :trashed
get "/monthly_chart_data" => "testers#monthly_chart_data", as: 'monthly_chart_data'
get "/yearly_chart_data" => "testers#yearly_chart_data", as: 'yearly_chart_data'
