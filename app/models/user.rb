class User < ActiveRecord::Base
  has_secure_password

  has_paper_trail

  validates :cell_phone_number, :presence => true, :uniqueness => true, :cell_phone_number_format => true
  validates :email, :presence => true, :uniqueness => true, :email_format => true
  validates :first_name, :presence => true
  validates :language, :presence => true
  validates :role, :presence => true
  validates :time_zone, :presence => true
  
  validates :terms_of_use, :acceptance => true, :on => :create
  
  attr_accessor :terms_of_use

  has_many :listings
  has_many :payments
  #has_many :comments

  ROLES = {
    # Translation                                   # Database key
    I18n.t("models.user.roles.user")          =>    "user",
    I18n.t("models.user.roles.administrator") =>    "administrator",
  }
  
  def admin?
    self.role == User::ROLES[I18n.t("models.user.roles.administrator")]
  end
end
