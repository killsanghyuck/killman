class Admin::ApplicationController < ApplicationController
  before_action :ensure_admin
  layout 'admin'

  private

  def ensure_admin
    unless user_signed_in? && (current_user.admin? || current_user.master?)
      redirect_to new_user_session_path, alert: '찾을 수 없는 페이지입니다.'
    end
  end

  def ensure_master
    unless user_signed_in? && current_user.master?
      redirect_to admin_root_path, alert: '권한이 없습니다.'
    end
  end
end
