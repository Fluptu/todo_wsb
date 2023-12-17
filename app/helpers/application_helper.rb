# frozen_string_literal: true

module ApplicationHelper
  def current_class?(active_path)
    'active' if request.path == active_path
  end
end
