class CourseImpression < ApplicationRecord
  belongs_to :course
  belongs_to :user


  # # handle impression DOS attack by checking user_id and ip address of last 100 impressions in last 10 seconds
  # def self.safe_create(course, user, request)
  #   return if user.nil?
  #   return if request.nil?
  #   return if course.nil?

  #   # check if there are more than 100 impressions in last 10 seconds from this user
  #   if CourseImpression.where(user_id: user.id).where('created_at > ?', 10.seconds.ago).count > 100
  #     return
  #   end

  #   # check if there are more than 100 impressions in last 10 seconds from this ip
  #   if CourseImpression.where(ip_address: request.remote_ip).where('created_at > ?', 10.seconds.ago).count > 100
  #     return
  #   end

  #   course.course_impressions.create(ip_address: request.remote_ip, user_id: user.id, viewed_at: Time.now)
  # end
  
end
