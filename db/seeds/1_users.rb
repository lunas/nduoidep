unless User.find_by_username('admin')
  admin_user = FactoryGirl.create :user
  admin_user.username = 'admin'
  admin_user.email = 'lukasnick@gmail.com'
  admin_user.password = 'ngouidep'
  admin_user.password_confirmation = admin_user.password
  admin_user.roles = ["admin"]
  admin_user.save!
end

