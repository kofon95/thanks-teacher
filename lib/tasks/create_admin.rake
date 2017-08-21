
namespace :admin do
  desc 'Creates admin with login and password. Example of use: rake admin:create[login,password]'
  task :create, [:login, :password] => :environment do |_, args|
    login, password = args[:login], args[:password]
    if login.nil? or password.nil?
      puts 'Wrong input'
      puts 'Example of use:
              rake admin:create[login,password]'
      next
    end
    if Admin.find_by_login(login).present?
      puts "Admin \"#{login}\" already exists"
      next
    end
    Admin.create! args.to_h
    puts "Admin \"#{login}\" with password \"#{password}\" has been created"
  end

  desc 'Removes admin by login. Example of use: rake admin:remove[login]'
  task :remove, [:login] => :environment do |_, args|
    login = args[:login]
    if login.nil?
      puts 'Login cannot be nil'
      puts 'Example of use:
              rake admin:remove[login]'
      next
    end

    admin = Admin.find_by_login(login)
    if admin.nil?
      puts "Admin \"#{login}\" not found"
      next
    end
    admin.destroy
    puts "Admin \"#{login}\" was successfully removed"
  end
end
