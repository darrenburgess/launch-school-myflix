require 'spec_helper'

describe VideosController do
  describe "GET show" do
    let(:video) { Fabricate :video }
    let(:user) { set_current_user }

    context "for authenticated users" do
      it "sets @video" do
        get :show, id: video.id
        expect(assigns(:video).should eq video)
      end

      it "sets @reviews" do
        review1 = Fabricate(:review, video: video, user: user)
        review2 = Fabricate(:review, video: video, user: user)
        get :show, id: video.id
        expect(assigns(:reviews)).to match_array([review1, review2])
      end
    end

    it_behaves_like "require sign in" do
      let(:action) { get :show, id: video.id }
    end
  end

  describe "POST search" do
    let(:video) { Fabricate :video }

    it "sets the @videos variable given a valid search for authenticated users" do
      set_current_user
      get :search, search_term: video.title
      expect(assigns(:videos)).to eq [video]
    end

    it "sets the @videos variable given a valid search for authenticated users" do
      get :search, search_term: video.title
      expect(response).to redirect_to signin_path
    end
  end
end
