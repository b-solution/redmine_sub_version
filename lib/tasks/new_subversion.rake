namespace :redmine_subversion do
  task :new => :environment do
    Version.where(parent_id: nil).each do |version|
      # if Subversion.where(parent_id: version.id, name: Subversion.generate_name(version)).blank?
        Subversion.create_subversion(version)
      # end
    end
  end
end