namespace :redmine_subversion do
  task :new => :environment do
    Version.where(parent_id: nil).each do |version|
      if Subversion.where(parent_id: version.id, name: Subversion.generate_name(version)).blank?
        subversion = Subversion.new(parent_id: version.id, name: Subversion.generate_name(version))
        subversion.attributes = version.attributes.stringify_key.except('id', 'name', 'type')
        subversion.save
      end
    end
  end
end