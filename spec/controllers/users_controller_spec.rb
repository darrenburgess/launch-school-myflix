require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "redirects to home_path for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path 
    end

    it "renders the new template" do
      get :new
      response.should render_template :new
    end

    it "sets the @user instance variable for unauthenticated users" do
      get :new
      assigns(:user).should be_new_record
      assigns(:user).should be_instance_of User
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user record" do
        expect(User.count).to eq 1
      end

      it "redirects to the signin path" do
        expect(response).to redirect_to signin_path 
      end
    end

    context "with invalid input" do
      before do
        post :create, user: { email: "invalid@example.com" }
      end

      it "does not create new user" do
        expect(User.count).to eq 0
      end

      it "renders new template" do
        response.should render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of User
      end
    end
  end
end
