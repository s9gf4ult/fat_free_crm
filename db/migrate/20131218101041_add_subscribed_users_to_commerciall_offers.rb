class AddSubscribedUsersToCommerciallOffers < ActiveRecord::Migration
  def change
    add_column :commercial_offers, :subscribed_users, :text
  end
end
