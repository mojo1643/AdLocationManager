class AdsManager < ActiveRecord::Base
	 validates :name, presence: true, length: { minimum: 5 }
     geocoded_by :address
	 reverse_geocoded_by :latitude, :longitude
     after_validation :geocode, :reverse_geocode


  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png", :url  => ":s3_domain_url", :path => "public/avatars/:id/:style_:basename.:extension", :storage => :fog, :fog_credentials => {provider: 'AWS', aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"], aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], region: ENV["FOG_REGION"]}, fog_directory: ENV["FOG_DIRECTORY"]


  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end