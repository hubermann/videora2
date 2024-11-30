class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      if current_user.creator?
        @created_courses = current_user.courses
      else
        @subscribed_courses = current_user.subscribed_courses
      end
    end
  end
  