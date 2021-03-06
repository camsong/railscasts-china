# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  token      :string(255)
#  name       :string(255)
#  email      :string(255)
#  admin      :boolean(1)
#  created_at :datetime
#  updated_at :datetime
#  uid        :string(255)
#  provider   :string(255)
#

class User < ActiveRecord::Base

  has_many :episodes

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
