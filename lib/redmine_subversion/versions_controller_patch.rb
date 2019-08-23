module RedmineSubversion
  module VersionsControllerPatch
    def self.included(base)
      base.send :include, InstanceMethods
      base.class_eval do
        alias_method :destroy_without_change, :destroy
        alias_method :destroy, :destroy_with_change

      end
    end

    module InstanceMethods
      def destroy_with_change
        if @version.deletable? || @version.parent_id.present?
          Issue.where(fixed_version_id: @version.id).update_all({fixed_version_id: (@version.next_version&.id || @version.parent&.id)}) if @version.parent_id.present?
          @version.destroy
          respond_to do |format|
            format.html { redirect_back_or_default settings_project_path(@project, :tab => 'versions') }
            format.api  { render_api_ok }
          end
        else
          respond_to do |format|
            format.html {
              flash[:error] = l(:notice_unable_delete_version)
              redirect_to settings_project_path(@project, :tab => 'versions')
            }
            format.api  { head :unprocessable_entity }
          end
        end
      end
    end
  end
end
VersionsController.send :include, RedmineSubversion::VersionsControllerPatch