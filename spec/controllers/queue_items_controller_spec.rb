require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to queue items of logged in user" do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user, video: video1)
      queue_item2 = Fabricate(:queue_item, user: user, video: video2)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "orders queue items by position ascending" do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item2 = Fabricate(:queue_item, video: video1, user: user, position: 2)
      queue_item1 = Fabricate(:queue_item, video: video2, user: user, position: 1)
      get :index
      expect(assigns(:queue_items)).to eq [queue_item1, queue_item2]
    end

    it "redirects to sign in page for unauthenticated user" do
      video1 = Fabricate(:video)
      video2 = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to signin_path
    end
  end

  describe "POST index" do
    context "with valid queue item object" do
      it "redirects to myqueue index page" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        post :create, video_id: video.id
        expect(response).to redirect_to queue_items_path
      end

      it "creates a queue item record" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        post :create, video_id: video.id
        expect(QueueItem.count).to eq 1
      end

      it "creates a queue item record associated with the current user" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq user
      end

      it "creates a queueitem record associated with a video" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq video
      end
    end

    context "with valid queue item object testing position" do
      it "creates a queue item in the last position" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        Fabricate(:queue_item, video: video1, user: user, position: 1)
        post :create, video_id: video2.id
        expect(QueueItem.last.position).to eq 2
      end

      it "creates a queue item in the first position if it is the first record" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        Fabricate(:queue_item, video: video, user: user, position: 1)
        post :create, video_id: video.id
        expect(QueueItem.first.position).to eq 1
      end
    end

    context "when video is already in queue" do
      it "renders video show page" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item = Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
        expect(response).to render_template "videos/show"
      end

      it "does not create queue item" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item = Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
        expect(QueueItem.count).to eq 1
      end

      it "messages the user" do
        video = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item = Fabricate(:queue_item, video: video, user: user)
        post :create, video_id: video.id
        expect(flash[:notice]).to_not be_blank
      end
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do
      it "redirects to queue items path" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id

        queue_item1 = Fabricate(:queue_item, user: user, position: 1, video: video1)
        queue_item2 = Fabricate(:queue_item, user: user, position: 2, video: video2)
        queue_items = [{id: queue_item1.id, position: queue_item1.position},
                       {id: queue_item2.id, position: queue_item2.position}]

        post :update_queue, queue_items: queue_items
        expect(response).to redirect_to queue_items_path
      end

      it "reorders the queue items" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id

        queue_item1 = Fabricate(:queue_item, position: 1, video: video1, user: user)
        queue_item2 = Fabricate(:queue_item, position: 2, video: video2, user: user)
        queue_items = [{id: queue_item1.id, position: 2},
                       {id: queue_item2.id, position: 1}]

        post :update_queue, queue_items: queue_items
        expect(user.queue_items).to eq [queue_item2, queue_item1]
      end

      it "normalizes the position to start with 1" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id

        queue_item1 = Fabricate(:queue_item, position: 1, video: video1, user: user)
        queue_item2 = Fabricate(:queue_item, position: 2, video: video2, user: user)
        queue_items = [{id: queue_item1.id, position: 3},
                       {id: queue_item2.id, position: 2}]

        post :update_queue, queue_items: queue_items
        expect(user.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do
      it "redirects to the queue items page" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, position: 1, video: video1, user: user)
        queue_item2 = Fabricate(:queue_item, position: 2, video: video2, user: user)
        queue_items = [{id: queue_item1.id, position: 3.2},
                       {id: queue_item2.id, position: 2}]

        post :update_queue, queue_items: queue_items
        expect(response).to redirect_to queue_items_path
      end

      it "sets the flash error message" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, position: 1, video: video1, user: user)
        queue_item2 = Fabricate(:queue_item, position: 2, video: video2, user: user)
        queue_items = [{id: queue_item1.id, position: 3.2},
                       {id: queue_item2.id, position: 2}]
        post :update_queue, queue_items: queue_items
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user = Fabricate(:user)
        session[:user_id] = user.id
        queue_item1 = Fabricate(:queue_item, position: 1, video: video1, user: user)
        queue_item2 = Fabricate(:queue_item, position: 2, video: video2, user: user)
        queue_items = [{id: queue_item1.id, position: 3},
                       {id: queue_item2.id, position: 2.1}]
        post :update_queue, queue_items: queue_items
        expect(queue_item1.reload.position).to eq 1
      end
    end

    context "unauthenticated users" do
      it "redirects to the sign in path" do
        queue_items = [{id: 1, position: 2},
                       {id: 2, position: 1}]
        post :update_queue, queue_items: queue_items
        expect(response).to redirect_to signin_path
      end
    end

    context "with queue items that do not belong to current user" do
      it "does not change the queue items" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        user1 = Fabricate(:user)
        session[:user_id] = user1.id
        user2 = Fabricate(:user)

        queue_item1 = Fabricate(:queue_item, position: 1, video: video1, user: user1)
        queue_item2 = Fabricate(:queue_item, position: 2, video: video2, user: user2)
        queue_items = [{id: queue_item1.id, position: 3},
                       {id: queue_item2.id, position: 2}]

        post :update_queue, queue_items: queue_items
        expect(queue_item1.reload.position).to eq 1
      end
    end
  end

  describe "DELETE destroy" do
    it "redirects to queue_item index page" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, video: video, user: user)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to queue_items_path
    end

    it "deletes queue item record" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, video: video, user: user)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq 0
    end

    it "normalizes remaining queuue items" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, video: video, user: user)
      video2 = Fabricate(:video)
      queue_item2 = Fabricate(:queue_item, video: video2, user: user)
      delete :destroy, id: queue_item.id
      expect(QueueItem.first.position).to eq 1
    end

    it "does not allow user to delete queue items of another user" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, video: video, user: user)
      other_user = Fabricate(:user)
      other_queue_item = Fabricate(:queue_item, user: other_user, video: video)
      delete :destroy, id: other_queue_item.id
      expect(other_user.queue_items.count).to eq 1
    end

    it "redirects to queue item page if user trys to delete item of another user" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, video: video, user: user)
      other_user = Fabricate(:user)
      other_queue_item = Fabricate(:queue_item, user: other_user, video: video)
      delete :destroy, id: other_queue_item.id
      expect(response).to redirect_to queue_items_path
    end

    it "redirects to signin page for unauthenticated users" do
      video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item = Fabricate(:queue_item, video: video, user: user)
      session[:user_id] = nil
      post :destroy, id: queue_item.id
      expect(response).to redirect_to signin_path
    end
  end
end