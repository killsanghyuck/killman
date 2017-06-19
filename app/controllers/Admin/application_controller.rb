class Admin::ApplicationController < ApplicationController
  before_action :ensure_admin
  layout 'admin'

  def ensure_admin
    unless user_signed_in? && (current_user.admin? || current_user.master?)
      redirect_to new_user_session_path, alert: '찾을 수 없는 페이지입니다.'
    end
  end
end
