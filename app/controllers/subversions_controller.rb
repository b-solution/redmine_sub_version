class SubversionsController < ApplicationController
  before_action :require_admin
  before_action :find_project_by_project_id

  def create
    @version = @project.versions.find(params[:id])
    Subversion.create_subversion(@version)
    redirect_to project_versions_path(@project)
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
