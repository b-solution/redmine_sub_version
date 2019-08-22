class Subversion < Version
  belongs_to :parent, class_name: 'Version'

  def next_version
    Subversion.where(parent_id: self.parent_id).where('id > ? ', self.id).first
  end

  def deletable?
    true && !referenced_by_a_custom_field? && attachments.empty?
  end

  def self.create_subversion(version)
    subversion = Subversion.new(parent_id: version.id, name: Subversion.generate_name(version))
    subversion.attributes = version.attributes.stringify_keys.except('id', 'name', 'type', 'parent_id')
    subversion.save
  end

  def self.generate_name(parent_version)
    name = if product_name(parent_version) && major_version(parent_version) && minor_version(parent_version)
      "#{product_name(parent_version)} #{major_version(parent_version)}#{minor_version(parent_version)} #{qf(parent_version)}"
    else
      parent_version.name
    end
    new_name = "#{name} #{Date.today.cweek}"
    if Version.where(name: new_name).present?
      new_name = "#{new_name}a"
    end
    while Version.where(name: new_name).present?
      new_name.succ!
    end
    new_name
  end

  def self.product_name parent_version
    object = Setting.plugin_redmine_sub_version['product_custom_field']
    if object
      vc = VersionCustomField.find(object)
      parent_version.custom_field_values.detect { |cf| cf.custom_field_id == vc.id }.try(:value)
    end
  end

  def self.major_version parent_version
    object = Setting.plugin_redmine_sub_version['major_version_custom_field']
    if object
      vc = VersionCustomField.find(object)
      parent_version.custom_field_values.detect { |cf| cf.custom_field_id == vc.id }.try(:value)
    end
  end

  def self.minor_version parent_version
    object = Setting.plugin_redmine_sub_version['minor_version_custom_field']
    if object
      vc = VersionCustomField.find(object)
      parent_version.custom_field_values.detect { |cf| cf.custom_field_id == vc.id }.try(:value)
    end
  end

  def self.qf parent_version
    object = Setting.plugin_redmine_sub_version['qf_custom_field']
    if object
      vc = VersionCustomField.find(object)
      parent_version.custom_field_values.detect { |cf| cf.custom_field_id == vc.id }.try(:value)
    end
  end
end
