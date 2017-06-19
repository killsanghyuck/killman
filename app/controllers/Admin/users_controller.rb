class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
    render 'admin/users/index'
  end
end
