class Subversion < Version
  belongs_to :parent, class_name: 'Version'

  before_destroy do
    Issue.where(fixed_version_id: self.id).update_all({fixed_version_id: (next_version || parent)})
  end

  def next_version
    Subversion.where(parent_id: self.parent_id).where('id > ? ', self.id).first
  end

  def self.generate_name(parent_version)
    name = parent_version.name
    week = Time.now.cweek
    "#{name} #{week}"
  end
end
