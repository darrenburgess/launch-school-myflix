require 'spec_helper'

describe VideosController do
  describe "GET show" do
    let(:video) { Fabricate :video }

    context "for authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
        get :show, id: video.id
      end

      it "sets @video" do
        expect(assigns(:video).should eq video)
      end

      it "sets @reviews" do
        review1 = Fabricate(:review, video: video, user_id: session[:user_id])
        review2 = Fabricate(:review, video: video, user_id: session[:user_id])
        expect(assigns(:reviews)).to match_array([review1, review2])
      end
    end

    context "for unauthentiated users" do
      it "redirects to the signin template" do
        get :show, id: video.id
        expect(response).to redirect_to signin_path
      end
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
