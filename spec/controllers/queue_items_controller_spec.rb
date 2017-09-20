require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to queue items of logged in user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user)
      queue_item2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
  
    it "redirects to sign in page for unauthenticated user" do
      get :index
      expect(response).to redirect_to signin_path
    end
  end
end
