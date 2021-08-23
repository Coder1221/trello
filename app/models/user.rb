class User < ApplicationRecord
  rolify strict: true
  
  has_many :boards
  
  attr_accessor :login

  has_many :invitations, class_name: 'User', as: :invited_by

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable 

  after_create :assign_default_role
  
  def assign_default_role
    self.add_role(:creator) if self.roles.blank?
  end

  def self.find_for_database_authentication warden_condition
    conditions = warden_condition.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.strip.downcase}]).first
  end   
end