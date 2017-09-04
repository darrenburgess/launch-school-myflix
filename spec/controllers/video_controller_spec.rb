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

  describe "GET search" do
    #context "with authenticated users" do
      #before do
        #session[:user_id] = Fabricate(:user).id
      #end

      #let(:video) { Fabricate :video }

      #it "sets the @videos variable given a valid search" do
        #get :search, title: video.title
        #expect(assigns(:video).should eq video)
      #end

      #it "renders the search template"
    #end
  end
end
