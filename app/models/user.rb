class User < ActiveRecord::Base
  # original_filename: config/initializers/paperclip.rb
  has_attached_file :avatar, 
  :storage => :s3,
  :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :bucket => ENV['S3_BUCKET'],
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :path => "/tmp/:id/:style_:original_filename",
  :url  => "/tmp/:id/:style/:original_filename"
end
