class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  mount_uploader :avatar, AvatarUploader
 
  def self.connect_to_social_sites(auth, signed_in_resource=nil)

    if auth.provider == "linkedin"
      puts auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        user.uimage = auth.info.image
        user.bio = auth.info.description
        user.industry = auth.info.industry
        user.location = auth.info.location

        # user.birth_date = auth.extra.raw_info.birthday.to_date if auth.extra.raw_info.birthday.present?
        # user.gender =  gender_parsing(auth.extra.raw_info.gender)
        # user.locale = auth.extra.raw_info.locale
        user.password = Devise.friendly_token[0,20]
        user.save!
        user
      end

    elsif auth.provider == "facebook"
      puts auth
       where(email: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name =auth.info.last_name
        user.uimage = auth.info.image
        user.birth_date = auth.extra.raw_info.birthday.to_date if auth.extra.raw_info.birthday.present?
        user.gender =  auth.extra.raw_info.gender
        user.locale = auth.extra.raw_info.locale
        user.location = auth.info.location
        user.password = Devise.friendly_token[0,20]
        user.save!
        user
      end 

    elsif auth.provider == "twitter"
      puts auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.name.split(" ").first
        user.last_name = auth.info.name.split(" ").last
        user.uimage = auth.info.image
        user.birth_date = auth.extra.raw_info.birthday.to_date if auth.extra.raw_info.birthday.present?
        user.bio = auth.info.description
        user.location = auth.info.location
        user.password = Devise.friendly_token[0,20]
        user.save!
        user
      end


    elsif auth.provider == "google_oauth2"
      puts auth
       where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name =auth.info.last_name
        user.uimage = auth.info.image
        user.birth_date = auth.extra.raw_info.birthday.to_date if auth.extra.raw_info.birthday.present?
        user.gender =  auth.extra.raw_info.gender
        user.locale = auth.extra.raw_info.locale
        user.location = auth.info.location
        user.password = Devise.friendly_token[0,20]
        user.save!
        user
      end
    end
  end
  
end
