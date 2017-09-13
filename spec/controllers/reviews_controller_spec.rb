require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    context "for authenticated users" do
      let(:video) { Fabricate(:video) } 
      let(:current_user) { Fabricate(:user) }

      before do
        session[:user_id] = current_user.id 
      end

      context "with valid input" do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id, user_id: session[:user_id] 
        end

        it "redirects to video show template" do
          expect(response).to redirect_to video_path(video)
        end

        it "creates review record" do
          expect(Review.count).to eq 1
        end

        it "creates review associated with video" do
          expect(Review.first.video).to eq video
        end

        it "creates review associated with signed in user" do
          expect(Review.first.user).to eq current_user
        end

        it "sets the success message" do
          expect(flash[:message]).to_not be_blank
        end
      end

      context "with invalid input" do
        before do
          post :create, review: { rating: nil, content: nil }, video_id: video.id, user_id: session[:user_id] 
        end

        it "renders video show template" do
          expect(response).to redirect_to video_path(video)
        end

        it "does not create review record" do
          expect(Review.count).to eq 0
        end

        it "sets the error message" do
          expect(flash[:error]).to_not be_blank
        end
      end
    end

    context "for unauthenticated users" do
      let(:video) { Fabricate(:video) }

      before do
        post :create, review:
          Fabricate.attributes_for(:review),
          video_id: video.id,
          user_id: nil
      end

      it "does not create review record" do
        expect(Review.count).to eq 0
      end
      
      it "redirects to signin path" do
        expect(response).to redirect_to signin_path
      end
    end
  end
end
