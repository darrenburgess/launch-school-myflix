shared_examples "require_sign_in" do
  it "redirects to signin page for unauthenticated users" do
    clear_current_user
    action
    response.should redirect_to signin_path
  end
end
