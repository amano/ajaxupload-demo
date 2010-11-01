class User < ActiveRecord::Base
  # original_filename: config/initializers/paperclip.rb
  has_attached_file :avatar, 
  :storage => :s3,
  :s3_credentials => {
    :access_key_id => ENV['S3_KEY'],
    :secret_access_key => ENV['S3_SECRET']
  },
  :bucket => ENV['S3_BUCKET'],
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :path => "/dev/ajaxupload-demo/:id/:style_:original_filename",
  :url  => "/dev/ajaxupload-demo/:id/:style_:original_filename"
end
