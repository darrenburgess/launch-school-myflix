require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    let(:video1) { Fabricate(:video) }
    let(:video2) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    
    before do
      session[:user_id] = user.id
    end

    it "sets @queue_items to queue items of logged in user" do
      queue_item1 = Fabricate(:queue_item, user: user, video: video1)
      queue_item2 = Fabricate(:queue_item, user: user, video: video2)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "orders queue items by position ascending" do
      queue_item2 = Fabricate(:queue_item, video: video1, user: user, position: 2)
      queue_item1 = Fabricate(:queue_item, video: video2, user: user, position: 1)
      get :index
      expect(assigns(:queue_items)).to eq [queue_item1, queue_item2]
    end

    it "redirects to sign in page for unauthenticated user" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to signin_path
    end
  end

  describe "POST index" do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    before do
      session[:user_id] = user.id
    end

    context "with valid queue item object" do
      before do
        post :create, video_id: video.id
      end

      it "redirects to myqueue index page" do
        expect(response).to redirect_to queue_items_path
      end

      it "creates a queue item record" do
        expect(QueueItem.count).to eq 1
      end

      it "creates a queue item record associated with the current user" do
        expect(QueueItem.first.user).to eq user
      end

      it "creates a queueitem record associated with a video" do
        expect(QueueItem.first.video).to eq video
      end
    end

    context "with valid queue item object testing position" do
      it "creates a queue item in the last position" do
        video1 = Fabricate(:video)
        Fabricate(:queue_item, video: video1, user: user, position: 1)
        post :create, video_id: video.id
        expect(QueueItem.last.position).to eq 2
      end

      it "creates a queue item in the first position if it is the first record" do
        post :create, video_id: video.id
        expect(QueueItem.first.position).to eq 1
      end
    end

    context "when video is already in queue" do
      before do
        queue_item = Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
      end

      it "renders video show page" do
        expect(response).to render_template "videos/show"
      end

      it "does not create queue item" do
        expect(QueueItem.count).to eq 1
      end

      it "messages the user" do
        expect(flash[:notice]).to_not be_blank
      end
    end
  end

  describe "DELETE destroy" do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, video: video, user: user) }

    before do
      session[:user_id] = user.id
    end

    it "redirects to queue_item index page" do
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to queue_items_path
    end

    it "deletes queue item record" do
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq 0
    end

    it "does not allow user to delete queue items of another user" do
      other_user = Fabricate(:user)
      other_queue_item = Fabricate(:queue_item, user: other_user, video: video)
      delete :destroy, id: other_queue_item.id
      expect(QueueItem.count).to eq 1
    end

    it "redirects to queue item page if user trys to delete item of another user" do
      other_user = Fabricate(:user)
      other_queue_item = Fabricate(:queue_item, user: other_user, video: video)
      delete :destroy, id: other_queue_item.id
      expect(response).to redirect_to queue_items_path
    end

    it "redirects to signin page for unauthenticated users" do
      session[:user_id] = nil
      post :destroy, id: queue_item.id
      expect(response).to redirect_to signin_path
    end
  end
end
