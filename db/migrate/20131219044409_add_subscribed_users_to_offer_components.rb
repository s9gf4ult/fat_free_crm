class AddSubscribedUsersToOfferComponents < ActiveRecord::Migration
  def change
    add_column :offer_components, :subscribed_users, :text
  end
end
