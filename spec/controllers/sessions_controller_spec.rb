require 'spec_helper'

describe SessionsController do
  describe "GET new" do
    it "redirects to home_path for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

    it "renders the new template for non-authenticated users" do 
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }

    context "with valid credentials" do
      before do
        post :create, { email: user.email, password: user.password }
      end

      it "sets the session user id" do
        expect(session[:user_id]).to eq user.id
      end

      it "sets the notice" do
        expect(flash[:notice]).not_to be_blank
      end

      it "redirects to the home path" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid credentials" do 
      before do
        post :create, { email: user.email, password: "wrong password" }
      end

      it "sets the error message" do
        expect(flash[:error]).not_to be_blank
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "POST destroy" do
    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "sets the session user id to nil" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the notice" do
      expect(flash[:notice]).to_not be_blank
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end
