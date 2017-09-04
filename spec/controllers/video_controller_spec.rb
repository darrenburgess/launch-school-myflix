require 'spec_helper'

describe VideosController do
  describe "GET show" do
    let(:video) { Fabricate :video }

    it "sets the @video variable for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
      expect(assigns(:video).should eq video)
    end

    it "redirects to the signin template for unauthenticated users" do
      get :show, id: video.id
      expect(response).to redirect_to signin_path
    end
  end

  describe "POST search" do
    let(:video) { Fabricate :video }

    it "sets the @videos variable given a valid search for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :search, search_term: video.title
      expect(assigns(:videos)).to eq [video]
    end

    it "sets the @videos variable given a valid search for authenticated users" do
      get :search, search_term: video.title
      expect(response).to redirect_to signin_path
    end
  end
end
